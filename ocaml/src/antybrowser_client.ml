open Lwt.Infix

type t = {
  api_key : string;
  base_url : string;
  timeout : float;
}

let create ~api_key ?(port = 5173) ?(base_url = "") ?(timeout = 30.0) () =
  let base =
    if base_url = "" then Printf.sprintf "http://127.0.0.1:%d" port
    else base_url
  in
  { api_key; base_url = base; timeout }

let raise_error ?status_code ?response_body msg =
  raise (Antybrowser_error.Antybrowser_error (msg, status_code, response_body))

let do_request ?(body : Yojson.Safe.t option) (client : t) (meth : Cohttp.Code.meth)
    (path : string) : Yojson.Safe.t Lwt.t =
  let uri =
    Uri.of_string (client.base_url ^ path)
  in
  let headers =
    Cohttp.Header.of_list
      [ ("x-api-key", client.api_key)
      ; ("content-type", "application/json")
      ]
  in
  let body_str =
    match body with
    | None -> None
    | Some json -> Some (Yojson.Safe.to_string json)
  in
  let req_body =
    match body_str with
    | None -> Cohttp_lwt.Body.empty
    | Some s -> Cohttp_lwt.Body.of_string s
  in
  Cohttp_lwt_unix.Client.call ~headers ~body:req_body meth uri
  >>= fun (resp, resp_body) ->
  let status = Cohttp.Response.status resp in
  let code = Cohttp.Code.code_of_status status in
  Cohttp_lwt.Body.to_string resp_body
  >>= fun resp_str ->
  if code < 200 || code >= 300 then
    raise_error ~status_code:code ~response_body:resp_str
      (Printf.sprintf "API request failed with status %d" code)
  else if resp_str = "" || resp_str = "null" then
    Lwt.return `Null
  else
    ( try Lwt.return (Yojson.Safe.from_string resp_str) with
    | Yojson.Json_error msg ->
      raise_error ~status_code:code ~response_body:resp_str
        (Printf.sprintf "Invalid JSON response: %s" msg)
    )

let get client path = do_request client `GET path

let post ?body client path = do_request ?body client `POST path

let put ?body client path = do_request ?body client `PUT path

let delete client path = do_request client `DELETE path

(* ── System ────────────────────────────────────────────────────────────── *)

let get_status client =
  get client "/api/status"
  >|= Antybrowser_types.status_response_of_json

let get_settings client =
  get client "/api/settings"
  >|= Antybrowser_types.settings_of_json

let get_sync_status client =
  get client "/api/sync/status"
  >|= Antybrowser_types.sync_status_of_json

let refresh_sync ?profile_id client =
  let body =
    match profile_id with
    | None -> `Assoc []
    | Some id -> `Assoc [ ("profileId", `Int id) ]
  in
  post ~body client "/api/sync/refresh"

(* ── Profiles ──────────────────────────────────────────────────────────── *)

let get_profiles client =
  get client "/api/profiles"
  >|= fun json ->
  Yojson.Safe.Util.to_list json |> List.map Antybrowser_types.profile_of_json

let create_profile client req =
  let body = Antybrowser_types.create_profile_request_to_json req in
  post ~body client "/api/profiles"
  >|= Antybrowser_types.profile_of_json

let update_profile client id data =
  let body = `Assoc (List.map (fun (k, v) -> (k, v)) data) in
  put ~body client (Printf.sprintf "/api/profiles/%d" id)
  >|= Antybrowser_types.profile_of_json

let delete_profile client id =
  delete client (Printf.sprintf "/api/profiles/%d" id)

let start_profile client id =
  post client (Printf.sprintf "/api/profiles/%d/start" id)
  >|= Antybrowser_types.start_profile_response_of_json

let stop_profile client id =
  post client (Printf.sprintf "/api/profiles/%d/stop" id)

let duplicate_profile client id ?req () =
  let body = Option.map Antybrowser_types.duplicate_profile_request_to_json req in
  post ?body client (Printf.sprintf "/api/profiles/%d/duplicate" id)
  >|= Antybrowser_types.profile_of_json

(* ── Automations ───────────────────────────────────────────────────────── *)

let get_automations client =
  get client "/api/automations"
  >|= fun json ->
  Yojson.Safe.Util.to_list json |> List.map Antybrowser_types.automation_of_json

let run_automation client id req =
  let body = Antybrowser_types.run_automation_request_to_json req in
  post ~body client (Printf.sprintf "/api/automations/%d/run" id)
  >|= Antybrowser_types.run_automation_result_of_json

(* ── Groups ────────────────────────────────────────────────────────────── *)

let get_groups client =
  get client "/api/groups"
  >|= fun json ->
  Yojson.Safe.Util.to_list json |> List.map Antybrowser_types.group_of_json

let create_group client req =
  let body = Antybrowser_types.create_group_request_to_json req in
  post ~body client "/api/groups"
  >|= Antybrowser_types.group_of_json

let update_group client id data =
  let body = `Assoc (List.map (fun (k, v) -> (k, v)) data) in
  put ~body client (Printf.sprintf "/api/groups/%d" id)
  >|= Antybrowser_types.group_of_json

let delete_group client id =
  delete client (Printf.sprintf "/api/groups/%d" id)

(* ── Proxies ───────────────────────────────────────────────────────────── *)

let get_proxies client =
  get client "/api/proxies"
  >|= fun json ->
  Yojson.Safe.Util.to_list json |> List.map Antybrowser_types.proxy_of_json

let create_proxy client req =
  let body = Antybrowser_types.create_proxy_request_to_json req in
  post ~body client "/api/proxies"
  >|= Antybrowser_types.proxy_of_json

let check_proxy client ~host ~port ?username ?password ?type_ () =
  let base = [ ("host", `String host); ("port", `Int port) ] in
  let with_user =
    match username with None -> base | Some u -> ("username", `String u) :: base
  in
  let with_pass =
    match password with None -> with_user | Some p -> ("password", `String p) :: with_user
  in
  let with_type =
    match type_ with None -> with_pass | Some t -> ("type", `String t) :: with_pass
  in
  post ~body:(`Assoc with_type) client "/api/proxies/check"
  >|= Antybrowser_types.proxy_check_result_of_json

let check_proxies_bulk client proxies =
  let body = `Assoc [ ("proxies", `List proxies) ] in
  post ~body client "/api/proxies/check-bulk"
  >|= fun json ->
  Yojson.Safe.Util.member "results" json
  |> Yojson.Safe.Util.to_list
  |> List.map Antybrowser_types.proxy_check_result_of_json

let delete_proxy client id =
  delete client (Printf.sprintf "/api/proxies/%d" id)

(* ── Extensions ────────────────────────────────────────────────────────── *)

let get_extensions client =
  get client "/api/extensions"
  >|= fun json ->
  Yojson.Safe.Util.to_list json |> List.map Antybrowser_types.extension_of_json

let delete_extension client id =
  delete client (Printf.sprintf "/api/extensions/%d" id)

let get_profile_extensions client ~profile_id ?(details = false) () =
  let path =
    Printf.sprintf "/api/profiles/%d/extensions?details=%b" profile_id details
  in
  get client path
  >|= fun json ->
  Yojson.Safe.Util.to_list json |> List.map Antybrowser_types.extension_of_json

let set_profile_extensions client ~profile_id extension_ids =
  let body =
    `Assoc
      [ ("extensionIds", `List (List.map (fun i -> `Int i) extension_ids)) ]
  in
  post ~body client (Printf.sprintf "/api/profiles/%d/extensions" profile_id)
