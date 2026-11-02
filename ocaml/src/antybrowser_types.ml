type start_profile_data = {
  debug_port : int;
}

type start_profile_response = {
  success : bool;
  data : start_profile_data;
}

type profile = {
  id : int;
  user_id : int option;
  user_guid : string option;
  name : string;
  directory_name : string option;
  group_id : int option;
  proxy_id : int option;
  browser_type : string option;
  browser_version : string option;
  os_fingerprint : string option;
  screen_resolution : string option;
  screen_maximizable : bool option;
  language : string option;
  accept_language : string option;
  timezone : string option;
  use_fingerprint : bool option;
  (* Server-owned noise seed. Read-only — never sent on create/update. *)
  fingerprint_id : string option;
  platform_version : string option;
  brand_version : string option;
  engine_version : string option;
  gpu_vendor : string option;
  gpu_model : string option;
  hardware_concurrency : Yojson.Safe.t option;
  device_memory : Yojson.Safe.t option;
  device_scale_factor : Yojson.Safe.t option;
  mobile_model : string option;
  mobile_version : Yojson.Safe.t option;
  ch_platform : string option;
  ch_platform_version : string option;
  ch_arch : string option;
  ch_bitness : string option;
  ch_model : string option;
  ch_mobile : Yojson.Safe.t option;
  disable_spoofing : string option;
  location_mode : string option;
  location_latitude : string option;
  location_longitude : string option;
  location_accuracy : string option;
  user_agent : string option;
  restore_session : bool option;
  low_bandwidth : bool option;
  notes : string option;
  start_url : string option;
  custom_flags : string option;
  status : string option;
  status_machine_id : string option;
  status_heartbeat_at : string option;
  needs_sync : bool option;
  last_pid : int option;
  debug_port : int option;
  tabs_snapshot : string option;
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
  browser_version : string option;
  os_fingerprint : string option;
  screen_resolution : string option;
  screen_maximizable : bool option;
  language : string option;
  accept_language : string option;
  timezone : string option;
  use_fingerprint : bool option;
  platform_version : string option;
  brand_version : string option;
  engine_version : string option;
  gpu_vendor : string option;
  gpu_model : string option;
  hardware_concurrency : Yojson.Safe.t option;
  device_memory : Yojson.Safe.t option;
  device_scale_factor : Yojson.Safe.t option;
  mobile_model : string option;
  mobile_version : Yojson.Safe.t option;
  ch_platform : string option;
  ch_platform_version : string option;
  ch_arch : string option;
  ch_bitness : string option;
  ch_model : string option;
  ch_mobile : Yojson.Safe.t option;
  disable_spoofing : string option;
  location_mode : string option;
  location_latitude : string option;
  location_longitude : string option;
  location_accuracy : string option;
  restore_session : bool option;
  low_bandwidth : bool option;
  notes : string option;
  start_url : string option;
  custom_flags : string option;
  status : string option;
  hidden : bool option;
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

let opt_json json key =
  match opt_field json key with
  | None | Some `Null -> None
  | Some j -> Some j

let json_string json key = opt_string json key |> Option.value ~default:""

let json_int json key = opt_int json key |> Option.value ~default:0

let json_bool json key = opt_bool json key |> Option.value ~default:false

let opt_to_json_string = function None -> `Null | Some s -> `String s

let opt_to_json_int = function None -> `Null | Some i -> `Int i

let opt_to_json_bool = function None -> `Null | Some b -> `Bool b

let opt_to_json_json = function None -> `Null | Some j -> j

(* ── Serialization ──────────────────────────────────────────────────────── *)

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
    ; ("userId", opt_to_json_int p.user_id)
    ; ("userGuid", opt_to_json_string p.user_guid)
    ; ("name", `String p.name)
    ; ("directoryName", opt_to_json_string p.directory_name)
    ; ("groupId", opt_to_json_int p.group_id)
    ; ("proxyId", opt_to_json_int p.proxy_id)
    ; ("browserType", opt_to_json_string p.browser_type)
    ; ("browserVersion", opt_to_json_string p.browser_version)
    ; ("osFingerprint", opt_to_json_string p.os_fingerprint)
    ; ("screenResolution", opt_to_json_string p.screen_resolution)
    ; ("screenMaximizable", opt_to_json_bool p.screen_maximizable)
    ; ("language", opt_to_json_string p.language)
    ; ("acceptLanguage", opt_to_json_string p.accept_language)
    ; ("timezone", opt_to_json_string p.timezone)
    ; ("useFingerprint", opt_to_json_bool p.use_fingerprint)
    ; ("fingerprintId", opt_to_json_string p.fingerprint_id)
    ; ("platformVersion", opt_to_json_string p.platform_version)
    ; ("brandVersion", opt_to_json_string p.brand_version)
    ; ("engineVersion", opt_to_json_string p.engine_version)
    ; ("gpuVendor", opt_to_json_string p.gpu_vendor)
    ; ("gpuModel", opt_to_json_string p.gpu_model)
    ; ("hardwareConcurrency", opt_to_json_json p.hardware_concurrency)
    ; ("deviceMemory", opt_to_json_json p.device_memory)
    ; ("deviceScaleFactor", opt_to_json_json p.device_scale_factor)
    ; ("mobileModel", opt_to_json_string p.mobile_model)
    ; ("mobileVersion", opt_to_json_json p.mobile_version)
    ; ("chPlatform", opt_to_json_string p.ch_platform)
    ; ("chPlatformVersion", opt_to_json_string p.ch_platform_version)
    ; ("chArch", opt_to_json_string p.ch_arch)
    ; ("chBitness", opt_to_json_string p.ch_bitness)
    ; ("chModel", opt_to_json_string p.ch_model)
    ; ("chMobile", opt_to_json_json p.ch_mobile)
    ; ("disableSpoofing", opt_to_json_string p.disable_spoofing)
    ; ("locationMode", opt_to_json_string p.location_mode)
    ; ("locationLatitude", opt_to_json_string p.location_latitude)
    ; ("locationLongitude", opt_to_json_string p.location_longitude)
    ; ("locationAccuracy", opt_to_json_string p.location_accuracy)
    ; ("userAgent", opt_to_json_string p.user_agent)
    ; ("restoreSession", opt_to_json_bool p.restore_session)
    ; ("lowBandwidth", opt_to_json_bool p.low_bandwidth)
    ; ("notes", opt_to_json_string p.notes)
    ; ("startUrl", opt_to_json_string p.start_url)
    ; ("customFlags", opt_to_json_string p.custom_flags)
    ; ("status", opt_to_json_string p.status)
    ; ("statusMachineId", opt_to_json_string p.status_machine_id)
    ; ("statusHeartbeatAt", opt_to_json_string p.status_heartbeat_at)
    ; ("needsSync", opt_to_json_bool p.needs_sync)
    ; ("lastPid", opt_to_json_int p.last_pid)
    ; ("debugPort", opt_to_json_int p.debug_port)
    ; ("tabsSnapshot", opt_to_json_string p.tabs_snapshot)
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
  ; user_id = opt_int json "userId"
  ; user_guid = opt_string json "userGuid"
  ; name = json_string json "name"
  ; directory_name = opt_string json "directoryName"
  ; group_id = opt_int json "groupId"
  ; proxy_id = opt_int json "proxyId"
  ; browser_type = opt_string json "browserType"
  ; browser_version = opt_string json "browserVersion"
  ; os_fingerprint = opt_string json "osFingerprint"
  ; screen_resolution = opt_string json "screenResolution"
  ; screen_maximizable = opt_bool json "screenMaximizable"
  ; language = opt_string json "language"
  ; accept_language = opt_string json "acceptLanguage"
  ; timezone = opt_string json "timezone"
  ; use_fingerprint = opt_bool json "useFingerprint"
  ; fingerprint_id = opt_string json "fingerprintId"
  ; platform_version = opt_string json "platformVersion"
  ; brand_version = opt_string json "brandVersion"
  ; engine_version = opt_string json "engineVersion"
  ; gpu_vendor = opt_string json "gpuVendor"
  ; gpu_model = opt_string json "gpuModel"
  ; hardware_concurrency = opt_json json "hardwareConcurrency"
  ; device_memory = opt_json json "deviceMemory"
  ; device_scale_factor = opt_json json "deviceScaleFactor"
  ; mobile_model = opt_string json "mobileModel"
  ; mobile_version = opt_json json "mobileVersion"
  ; ch_platform = opt_string json "chPlatform"
  ; ch_platform_version = opt_string json "chPlatformVersion"
  ; ch_arch = opt_string json "chArch"
  ; ch_bitness = opt_string json "chBitness"
  ; ch_model = opt_string json "chModel"
  ; ch_mobile = opt_json json "chMobile"
  ; disable_spoofing = opt_string json "disableSpoofing"
  ; location_mode = opt_string json "locationMode"
  ; location_latitude = opt_string json "locationLatitude"
  ; location_longitude = opt_string json "locationLongitude"
  ; location_accuracy = opt_string json "locationAccuracy"
  ; user_agent = opt_string json "userAgent"
  ; restore_session = opt_bool json "restoreSession"
  ; low_bandwidth = opt_bool json "lowBandwidth"
  ; notes = opt_string json "notes"
  ; start_url = opt_string json "startUrl"
  ; custom_flags = opt_string json "customFlags"
  ; status = opt_string json "status"
  ; status_machine_id = opt_string json "statusMachineId"
  ; status_heartbeat_at = opt_string json "statusHeartbeatAt"
  ; needs_sync = opt_bool json "needsSync"
  ; last_pid = opt_int json "lastPid"
  ; debug_port = opt_int json "debugPort"
  ; tabs_snapshot = opt_string json "tabsSnapshot"
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
    ; ("browserVersion", opt_to_json_string r.browser_version)
    ; ("osFingerprint", opt_to_json_string r.os_fingerprint)
    ; ("screenResolution", opt_to_json_string r.screen_resolution)
    ; ("screenMaximizable", opt_to_json_bool r.screen_maximizable)
    ; ("language", opt_to_json_string r.language)
    ; ("acceptLanguage", opt_to_json_string r.accept_language)
    ; ("timezone", opt_to_json_string r.timezone)
    ; ("useFingerprint", opt_to_json_bool r.use_fingerprint)
    ; ("platformVersion", opt_to_json_string r.platform_version)
    ; ("brandVersion", opt_to_json_string r.brand_version)
    ; ("engineVersion", opt_to_json_string r.engine_version)
    ; ("gpuVendor", opt_to_json_string r.gpu_vendor)
    ; ("gpuModel", opt_to_json_string r.gpu_model)
    ; ("hardwareConcurrency", opt_to_json_json r.hardware_concurrency)
    ; ("deviceMemory", opt_to_json_json r.device_memory)
    ; ("deviceScaleFactor", opt_to_json_json r.device_scale_factor)
    ; ("mobileModel", opt_to_json_string r.mobile_model)
    ; ("mobileVersion", opt_to_json_json r.mobile_version)
    ; ("chPlatform", opt_to_json_string r.ch_platform)
    ; ("chPlatformVersion", opt_to_json_string r.ch_platform_version)
    ; ("chArch", opt_to_json_string r.ch_arch)
    ; ("chBitness", opt_to_json_string r.ch_bitness)
    ; ("chModel", opt_to_json_string r.ch_model)
    ; ("chMobile", opt_to_json_json r.ch_mobile)
    ; ("disableSpoofing", opt_to_json_string r.disable_spoofing)
    ; ("locationMode", opt_to_json_string r.location_mode)
    ; ("locationLatitude", opt_to_json_string r.location_latitude)
    ; ("locationLongitude", opt_to_json_string r.location_longitude)
    ; ("locationAccuracy", opt_to_json_string r.location_accuracy)
    ; ("restoreSession", opt_to_json_bool r.restore_session)
    ; ("lowBandwidth", opt_to_json_bool r.low_bandwidth)
    ; ("notes", opt_to_json_string r.notes)
    ; ("startUrl", opt_to_json_string r.start_url)
    ; ("customFlags", opt_to_json_string r.custom_flags)
    ; ("status", opt_to_json_string r.status)
    ; ("hidden", opt_to_json_bool r.hidden)
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

let duplicate_profile_request_to_json r =
  `Assoc
    [ ("name", opt_to_json_string r.name)
    ; ("directoryName", opt_to_json_string r.directory_name)
    ]
