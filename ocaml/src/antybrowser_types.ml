type status_response = {
  success : bool;
  status : string;
  version : string;
}

type start_profile_data = {
  debug_port : int;
}

type start_profile_response = {
  success : bool;
  data : start_profile_data;
}

type profile = {
  id : int;
  name : string;
  directory_name : string option;
  group_id : int option;
  proxy_id : int option;
  browser_type : string option;
  browser_version : string option;
  os_fingerprint : string option;
  screen_resolution : string option;
  language : string option;
  accept_language : string option;
  timezone : string option;
  use_fingerprint : bool option;
  fingerprint_id : string option;
  restore_session : bool option;
  low_bandwidth : bool option;
  notes : string option;
  start_url : string option;
  custom_flags : string option;
  status : string option;
  needs_sync : bool option;
  last_pid : int option;
  debug_port : int option;
  created_at : string option;
  updated_at : string option;
  last_synced_at : string option;
  s3_key : string option;
  trash : bool option;
  deleted_at : string option;
  hidden : bool option;
}

type create_profile_request = {
  name : string;
  directory_name : string option;
  group_id : int option;
  proxy_id : int option;
  browser_type : string option;
  os_fingerprint : string option;
  screen_resolution : string option;
  language : string option;
  accept_language : string option;
  timezone : string option;
  use_fingerprint : bool option;
  fingerprint_id : string option;
  restore_session : bool option;
  low_bandwidth : bool option;
  notes : string option;
  start_url : string option;
  custom_flags : string option;
}

type proxy = {
  id : int;
  name : string option;
  type_ : string option;
  host : string option;
  port : int option;
  username : string option;
  password : string option;
  status : string option;
  country_code : string option;
  ip : string option;
  country : string option;
  timezone : string option;
  asn : string option;
  isp : string option;
}

type create_proxy_request = {
  name : string;
  host : string;
  port : int;
  type_ : string;
  username : string option;
  password : string option;
}

type proxy_check_result = {
  success : bool;
  details : Yojson.Safe.t;
  error_message : string option;
}

type group = {
  id : int;
  name : string;
  description : string option;
  color : string option;
  display_order : int option;
  created_at : string option;
  updated_at : string option;
}

type create_group_request = {
  name : string;
  description : string option;
  color : string option;
}

type extension = {
  id : int;
  name : string;
  path : string option;
  description : string option;
  icon : string option;
  icon_data_url : string option;
  created_at : string option;
}

type automation = {
  id : int;
  name : string;
  description : string option;
  status : string option;
  last_run : string option;
  created_at : string option;
  updated_at : string option;
}

type run_automation_request = {
  profile_id : int;
  delete_cookies : bool option;
  variables : (string * string) list;
}

type run_automation_result = {
  success : bool;
  message : string;
  variables : (string * Yojson.Safe.t) list;
}

type settings = {
  id : int option;
  chrome_path : string option;
  api_key : string option;
  language : string option;
}

type sync_status = {
  active : Yojson.Safe.t list;
  active_extensions : Yojson.Safe.t list;
  total : int;
  completed : int;
  errors : Yojson.Safe.t;
  progress : Yojson.Safe.t;
  is_syncing : bool;
}

type duplicate_profile_request = {
  name : string option;
  directory_name : string option;
}

(* ── JSON helpers ───────────────────────────────────────────────────────── *)

let opt_field json key =
  try Some (Yojson.Safe.Util.member key json) with _ -> None

let opt_string json key =
  match opt_field json key with
  | None | Some `Null -> None
  | Some (`String s) -> Some s
  | Some _ -> None

let opt_int json key =
  match opt_field json key with
  | None | Some `Null -> None
  | Some (`Int i) -> Some i
  | Some _ -> None

let opt_bool json key =
  match opt_field json key with
  | None | Some `Null -> None
  | Some (`Bool b) -> Some b
  | Some _ -> None

let json_string json key = opt_string json key |> Option.value ~default:""

let json_int json key = opt_int json key |> Option.value ~default:0

let json_bool json key = opt_bool json key |> Option.value ~default:false

let opt_to_json_string = function None -> `Null | Some s -> `String s

let opt_to_json_int = function None -> `Null | Some i -> `Int i

let opt_to_json_bool = function None -> `Null | Some b -> `Bool b

(* ── Serialization ──────────────────────────────────────────────────────── *)

let status_response_to_json r =
  `Assoc
    [ ("success", `Bool r.success)
    ; ("status", `String r.status)
    ; ("version", `String r.version)
    ]

let status_response_of_json json =
  { success = json_bool json "success"
  ; status = json_string json "status"
  ; version = json_string json "version"
  }

let start_profile_data_to_json d =
  `Assoc [ ("debugPort", `Int d.debug_port) ]

let start_profile_data_of_json json =
  { debug_port = json_int json "debugPort" }

let start_profile_response_to_json r =
  `Assoc
    [ ("success", `Bool r.success)
    ; ("data", start_profile_data_to_json r.data)
    ]

let start_profile_response_of_json json =
  { success = json_bool json "success"
  ; data = start_profile_data_of_json (Yojson.Safe.Util.member "data" json)
  }

let profile_to_json p =
  `Assoc
    [ ("id", `Int p.id)
    ; ("name", `String p.name)
    ; ("directoryName", opt_to_json_string p.directory_name)
    ; ("groupId", opt_to_json_int p.group_id)
    ; ("proxyId", opt_to_json_int p.proxy_id)
    ; ("browserType", opt_to_json_string p.browser_type)
    ; ("browserVersion", opt_to_json_string p.browser_version)
    ; ("osFingerprint", opt_to_json_string p.os_fingerprint)
    ; ("screenResolution", opt_to_json_string p.screen_resolution)
    ; ("language", opt_to_json_string p.language)
    ; ("acceptLanguage", opt_to_json_string p.accept_language)
    ; ("timezone", opt_to_json_string p.timezone)
    ; ("useFingerprint", opt_to_json_bool p.use_fingerprint)
    ; ("fingerprintId", opt_to_json_string p.fingerprint_id)
    ; ("restoreSession", opt_to_json_bool p.restore_session)
    ; ("lowBandwidth", opt_to_json_bool p.low_bandwidth)
    ; ("notes", opt_to_json_string p.notes)
    ; ("startUrl", opt_to_json_string p.start_url)
    ; ("customFlags", opt_to_json_string p.custom_flags)
    ; ("status", opt_to_json_string p.status)
    ; ("needsSync", opt_to_json_bool p.needs_sync)
    ; ("lastPid", opt_to_json_int p.last_pid)
    ; ("debugPort", opt_to_json_int p.debug_port)
    ; ("createdAt", opt_to_json_string p.created_at)
    ; ("updatedAt", opt_to_json_string p.updated_at)
    ; ("lastSyncedAt", opt_to_json_string p.last_synced_at)
    ; ("s3Key", opt_to_json_string p.s3_key)
    ; ("trash", opt_to_json_bool p.trash)
    ; ("deletedAt", opt_to_json_string p.deleted_at)
    ; ("hidden", opt_to_json_bool p.hidden)
    ]

let profile_of_json json =
  { id = json_int json "id"
  ; name = json_string json "name"
  ; directory_name = opt_string json "directoryName"
  ; group_id = opt_int json "groupId"
  ; proxy_id = opt_int json "proxyId"
  ; browser_type = opt_string json "browserType"
  ; browser_version = opt_string json "browserVersion"
  ; os_fingerprint = opt_string json "osFingerprint"
  ; screen_resolution = opt_string json "screenResolution"
  ; language = opt_string json "language"
  ; accept_language = opt_string json "acceptLanguage"
  ; timezone = opt_string json "timezone"
  ; use_fingerprint = opt_bool json "useFingerprint"
  ; fingerprint_id = opt_string json "fingerprintId"
  ; restore_session = opt_bool json "restoreSession"
  ; low_bandwidth = opt_bool json "lowBandwidth"
  ; notes = opt_string json "notes"
  ; start_url = opt_string json "startUrl"
  ; custom_flags = opt_string json "customFlags"
  ; status = opt_string json "status"
  ; needs_sync = opt_bool json "needsSync"
  ; last_pid = opt_int json "lastPid"
  ; debug_port = opt_int json "debugPort"
  ; created_at = opt_string json "createdAt"
  ; updated_at = opt_string json "updatedAt"
  ; last_synced_at = opt_string json "lastSyncedAt"
  ; s3_key = opt_string json "s3Key"
  ; trash = opt_bool json "trash"
  ; deleted_at = opt_string json "deletedAt"
  ; hidden = opt_bool json "hidden"
  }

let create_profile_request_to_json r =
  `Assoc
    [ ("name", `String r.name)
    ; ("directoryName", opt_to_json_string r.directory_name)
    ; ("groupId", opt_to_json_int r.group_id)
    ; ("proxyId", opt_to_json_int r.proxy_id)
    ; ("browserType", opt_to_json_string r.browser_type)
    ; ("osFingerprint", opt_to_json_string r.os_fingerprint)
    ; ("screenResolution", opt_to_json_string r.screen_resolution)
    ; ("language", opt_to_json_string r.language)
    ; ("acceptLanguage", opt_to_json_string r.accept_language)
    ; ("timezone", opt_to_json_string r.timezone)
    ; ("useFingerprint", opt_to_json_bool r.use_fingerprint)
    ; ("fingerprintId", opt_to_json_string r.fingerprint_id)
    ; ("restoreSession", opt_to_json_bool r.restore_session)
    ; ("lowBandwidth", opt_to_json_bool r.low_bandwidth)
    ; ("notes", opt_to_json_string r.notes)
    ; ("startUrl", opt_to_json_string r.start_url)
    ; ("customFlags", opt_to_json_string r.custom_flags)
    ]

let proxy_to_json p =
  `Assoc
    [ ("id", `Int p.id)
    ; ("name", opt_to_json_string p.name)
    ; ("type", opt_to_json_string p.type_)
    ; ("host", opt_to_json_string p.host)
    ; ("port", opt_to_json_int p.port)
    ; ("username", opt_to_json_string p.username)
    ; ("password", opt_to_json_string p.password)
    ; ("status", opt_to_json_string p.status)
    ; ("countryCode", opt_to_json_string p.country_code)
    ; ("ip", opt_to_json_string p.ip)
    ; ("country", opt_to_json_string p.country)
    ; ("timezone", opt_to_json_string p.timezone)
    ; ("asn", opt_to_json_string p.asn)
    ; ("isp", opt_to_json_string p.isp)
    ]

let proxy_of_json json =
  { id = json_int json "id"
  ; name = opt_string json "name"
  ; type_ = opt_string json "type"
  ; host = opt_string json "host"
  ; port = opt_int json "port"
  ; username = opt_string json "username"
  ; password = opt_string json "password"
  ; status = opt_string json "status"
  ; country_code = opt_string json "countryCode"
  ; ip = opt_string json "ip"
  ; country = opt_string json "country"
  ; timezone = opt_string json "timezone"
  ; asn = opt_string json "asn"
  ; isp = opt_string json "isp"
  }

let create_proxy_request_to_json r =
  `Assoc
    [ ("name", `String r.name)
    ; ("host", `String r.host)
    ; ("port", `Int r.port)
    ; ("type", `String r.type_)
    ; ("username", opt_to_json_string r.username)
    ; ("password", opt_to_json_string r.password)
    ]

let proxy_check_result_to_json r =
  `Assoc
    [ ("success", `Bool r.success)
    ; ("details", r.details)
    ; ("errorMessage", opt_to_json_string r.error_message)
    ]

let proxy_check_result_of_json json =
  { success = json_bool json "success"
  ; details =
      ( match opt_field json "details" with
      | Some j -> j
      | None -> `Assoc []
      )
  ; error_message = opt_string json "errorMessage"
  }

let group_to_json g =
  `Assoc
    [ ("id", `Int g.id)
    ; ("name", `String g.name)
    ; ("description", opt_to_json_string g.description)
    ; ("color", opt_to_json_string g.color)
    ; ("displayOrder", opt_to_json_int g.display_order)
    ; ("createdAt", opt_to_json_string g.created_at)
    ; ("updatedAt", opt_to_json_string g.updated_at)
    ]

let group_of_json json =
  { id = json_int json "id"
  ; name = json_string json "name"
  ; description = opt_string json "description"
  ; color = opt_string json "color"
  ; display_order = opt_int json "displayOrder"
  ; created_at = opt_string json "createdAt"
  ; updated_at = opt_string json "updatedAt"
  }

let create_group_request_to_json r =
  `Assoc
    [ ("name", `String r.name)
    ; ("description", opt_to_json_string r.description)
    ; ("color", opt_to_json_string r.color)
    ]

let extension_to_json e =
  `Assoc
    [ ("id", `Int e.id)
    ; ("name", `String e.name)
    ; ("path", opt_to_json_string e.path)
    ; ("description", opt_to_json_string e.description)
    ; ("icon", opt_to_json_string e.icon)
    ; ("iconDataUrl", opt_to_json_string e.icon_data_url)
    ; ("createdAt", opt_to_json_string e.created_at)
    ]

let extension_of_json json =
  { id = json_int json "id"
  ; name = json_string json "name"
  ; path = opt_string json "path"
  ; description = opt_string json "description"
  ; icon = opt_string json "icon"
  ; icon_data_url = opt_string json "iconDataUrl"
  ; created_at = opt_string json "createdAt"
  }

let automation_to_json a =
  `Assoc
    [ ("id", `Int a.id)
    ; ("name", `String a.name)
    ; ("description", opt_to_json_string a.description)
    ; ("status", opt_to_json_string a.status)
    ; ("lastRun", opt_to_json_string a.last_run)
    ; ("createdAt", opt_to_json_string a.created_at)
    ; ("updatedAt", opt_to_json_string a.updated_at)
    ]

let automation_of_json json =
  { id = json_int json "id"
  ; name = json_string json "name"
  ; description = opt_string json "description"
  ; status = opt_string json "status"
  ; last_run = opt_string json "lastRun"
  ; created_at = opt_string json "createdAt"
  ; updated_at = opt_string json "updatedAt"
  }

let run_automation_request_to_json r =
  `Assoc
    [ ("profileId", `Int r.profile_id)
    ; ("deleteCookies", opt_to_json_bool r.delete_cookies)
    ; ("variables", `Assoc (List.map (fun (k, v) -> (k, `String v)) r.variables))
    ]

let run_automation_result_to_json r =
  `Assoc
    [ ("success", `Bool r.success)
    ; ("message", `String r.message)
    ; ("variables", `Assoc r.variables)
    ]

let run_automation_result_of_json json =
  { success = json_bool json "success"
  ; message = json_string json "message"
  ; variables =
      ( match opt_field json "variables" with
      | Some (`Assoc kvs) -> List.map (fun (k, v) -> (k, v)) kvs
      | _ -> []
      )
  }

let settings_to_json s =
  `Assoc
    [ ("id", opt_to_json_int s.id)
    ; ("chromePath", opt_to_json_string s.chrome_path)
    ; ("apiKey", opt_to_json_string s.api_key)
    ; ("language", opt_to_json_string s.language)
    ]

let settings_of_json json =
  { id = opt_int json "id"
  ; chrome_path = opt_string json "chromePath"
  ; api_key = opt_string json "apiKey"
  ; language = opt_string json "language"
  }

let sync_status_to_json s =
  `Assoc
    [ ("active", s.active)
    ; ("activeExtensions", s.active_extensions)
    ; ("total", `Int s.total)
    ; ("completed", `Int s.completed)
    ; ("errors", s.errors)
    ; ("progress", s.progress)
    ; ("isSyncing", `Bool s.is_syncing)
    ]

let sync_status_of_json json =
  { active =
      ( match opt_field json "active" with
      | Some (`List l) -> l
      | _ -> []
      )
  ; active_extensions =
      ( match opt_field json "activeExtensions" with
      | Some (`List l) -> l
      | _ -> []
      )
  ; total = json_int json "total"
  ; completed = json_int json "completed"
  ; errors =
      ( match opt_field json "errors" with
      | Some j -> j
      | None -> `Assoc []
      )
  ; progress =
      ( match opt_field json "progress" with
      | Some j -> j
      | None -> `Assoc []
      )
  ; is_syncing = json_bool json "isSyncing"
  }

let duplicate_profile_request_to_json r =
  `Assoc
    [ ("name", opt_to_json_string r.name)
    ; ("directoryName", opt_to_json_string r.directory_name)
    ]
