(** OCaml SDK for the Antybrowser Local API *)

(** {1 Types} *)

type status_response = Antybrowser_types.status_response = {
  success : bool;
  status : string;
  version : string;
}

type start_profile_data = Antybrowser_types.start_profile_data = {
  debug_port : int;
}

type start_profile_response = Antybrowser_types.start_profile_response = {
  success : bool;
  data : start_profile_data;
}

type profile = Antybrowser_types.profile = {
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

type create_profile_request = Antybrowser_types.create_profile_request = {
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

type proxy = Antybrowser_types.proxy = {
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

type create_proxy_request = Antybrowser_types.create_proxy_request = {
  name : string;
  host : string;
  port : int;
  type_ : string;
  username : string option;
  password : string option;
}

type proxy_check_result = Antybrowser_types.proxy_check_result = {
  success : bool;
  details : Yojson.Safe.t;
  error_message : string option;
}

type group = Antybrowser_types.group = {
  id : int;
  name : string;
  description : string option;
  color : string option;
  display_order : int option;
  created_at : string option;
  updated_at : string option;
}

type create_group_request = Antybrowser_types.create_group_request = {
  name : string;
  description : string option;
  color : string option;
}

type extension = Antybrowser_types.extension = {
  id : int;
  name : string;
  path : string option;
  description : string option;
  icon : string option;
  icon_data_url : string option;
  created_at : string option;
}

type automation = Antybrowser_types.automation = {
  id : int;
  name : string;
  description : string option;
  status : string option;
  last_run : string option;
  created_at : string option;
  updated_at : string option;
}

type run_automation_request = Antybrowser_types.run_automation_request = {
  profile_id : int;
  delete_cookies : bool option;
  variables : (string * string) list;
}

type run_automation_result = Antybrowser_types.run_automation_result = {
  success : bool;
  message : string;
  variables : (string * Yojson.Safe.t) list;
}

type settings = Antybrowser_types.settings = {
  id : int option;
  chrome_path : string option;
  api_key : string option;
  language : string option;
}

type sync_status = Antybrowser_types.sync_status = {
  active : Yojson.Safe.t list;
  active_extensions : Yojson.Safe.t list;
  total : int;
  completed : int;
  errors : Yojson.Safe.t;
  progress : Yojson.Safe.t;
  is_syncing : bool;
}

type duplicate_profile_request = Antybrowser_types.duplicate_profile_request = {
  name : string option;
  directory_name : string option;
}

(** {1 JSON Serialization} *)

val status_response_to_json : status_response -> Yojson.Safe.t
val status_response_of_json : Yojson.Safe.t -> status_response
val start_profile_response_to_json : start_profile_response -> Yojson.Safe.t
val start_profile_response_of_json : Yojson.Safe.t -> start_profile_response
val profile_to_json : profile -> Yojson.Safe.t
val profile_of_json : Yojson.Safe.t -> profile
val create_profile_request_to_json : create_profile_request -> Yojson.Safe.t
val proxy_to_json : proxy -> Yojson.Safe.t
val proxy_of_json : Yojson.Safe.t -> proxy
val create_proxy_request_to_json : create_proxy_request -> Yojson.Safe.t
val proxy_check_result_to_json : proxy_check_result -> Yojson.Safe.t
val proxy_check_result_of_json : Yojson.Safe.t -> proxy_check_result
val group_to_json : group -> Yojson.Safe.t
val group_of_json : Yojson.Safe.t -> group
val create_group_request_to_json : create_group_request -> Yojson.Safe.t
val extension_to_json : extension -> Yojson.Safe.t
val extension_of_json : Yojson.Safe.t -> extension
val automation_to_json : automation -> Yojson.Safe.t
val automation_of_json : Yojson.Safe.t -> automation
val run_automation_request_to_json : run_automation_request -> Yojson.Safe.t
val run_automation_result_to_json : run_automation_result -> Yojson.Safe.t
val run_automation_result_of_json : Yojson.Safe.t -> run_automation_result
val settings_to_json : settings -> Yojson.Safe.t
val settings_of_json : Yojson.Safe.t -> settings
val sync_status_to_json : sync_status -> Yojson.Safe.t
val sync_status_of_json : Yojson.Safe.t -> sync_status
val duplicate_profile_request_to_json : duplicate_profile_request -> Yojson.Safe.t

(** {1 Errors} *)

exception Antybrowser_error of string * int option * string option

val to_string : string * int option * string option -> string

(** {1 Client} *)

module Client : sig
  type t

  val create :
    api_key:string ->
    ?port:int ->
    ?base_url:string ->
    ?timeout:float ->
    unit ->
    t

  (** {2 System} *)

  val get_status : t -> status_response Lwt.t
  val get_settings : t -> settings Lwt.t
  val get_sync_status : t -> sync_status Lwt.t
  val refresh_sync : ?profile_id:int -> t -> Yojson.Safe.t Lwt.t

  (** {2 Profiles} *)

  val get_profiles : t -> profile list Lwt.t
  val create_profile : t -> create_profile_request -> profile Lwt.t
  val update_profile :
    t -> int -> (string * Yojson.Safe.t) list -> profile Lwt.t
  val delete_profile : t -> int -> Yojson.Safe.t Lwt.t
  val start_profile : t -> int -> start_profile_response Lwt.t
  val stop_profile : t -> int -> Yojson.Safe.t Lwt.t

  val duplicate_profile :
    t -> int -> ?req:duplicate_profile_request -> unit -> profile Lwt.t

  (** {2 Automations} *)

  val get_automations : t -> automation list Lwt.t

  val run_automation :
    t -> int -> run_automation_request -> run_automation_result Lwt.t

  (** {2 Groups} *)

  val get_groups : t -> group list Lwt.t
  val create_group : t -> create_group_request -> group Lwt.t
  val update_group :
    t -> int -> (string * Yojson.Safe.t) list -> group Lwt.t
  val delete_group : t -> int -> Yojson.Safe.t Lwt.t

  (** {2 Proxies} *)

  val get_proxies : t -> proxy list Lwt.t
  val create_proxy : t -> create_proxy_request -> proxy Lwt.t

  val check_proxy :
    t ->
    host:string ->
    port:int ->
    ?username:string ->
    ?password:string ->
    ?type_:string ->
    unit ->
    proxy_check_result Lwt.t

  val check_proxies_bulk :
    t -> Yojson.Safe.t list -> proxy_check_result list Lwt.t

  val delete_proxy : t -> int -> Yojson.Safe.t Lwt.t

  (** {2 Extensions} *)

  val get_extensions : t -> extension list Lwt.t
  val delete_extension : t -> int -> Yojson.Safe.t Lwt.t

  val get_profile_extensions :
    t -> profile_id:int -> ?details:bool -> unit -> extension list Lwt.t

  val set_profile_extensions :
    t -> profile_id:int -> int list -> Yojson.Safe.t Lwt.t
end
