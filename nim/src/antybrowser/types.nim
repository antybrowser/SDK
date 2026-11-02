import std/json
import std/options

type
  Proxy* = object
    id*: Option[string]
    name*: Option[string]
    host*: Option[string]
    port*: Option[int]
    username*: Option[string]
    password*: Option[string]
    `type`*: Option[string]

  Profile* = object
    id*: Option[string]
    user_id*: Option[int]
    user_guid*: Option[string]
    name*: Option[string]
    directory_name*: Option[string]
    group_id*: Option[string]
    proxy_id*: Option[string]
    browser_type*: Option[string]
    browser_version*: Option[string]
    os_fingerprint*: Option[string]
    screen_resolution*: Option[string]
    screen_maximizable*: Option[bool]
    language*: Option[string]
    accept_language*: Option[string]
    timezone*: Option[string]
    use_fingerprint*: Option[bool]
    # Server-owned noise seed. Read-only — never sent on create/update.
    fingerprint_id*: Option[string]
    # --- Fingerprint surface ---
    platform_version*: Option[string]
    brand_version*: Option[string]
    engine_version*: Option[string]
    gpu_vendor*: Option[string]
    gpu_model*: Option[string]
    hardware_concurrency*: Option[JsonNode]
    device_memory*: Option[JsonNode]
    device_scale_factor*: Option[JsonNode]
    mobile_model*: Option[string]
    mobile_version*: Option[JsonNode]
    ch_platform*: Option[string]
    ch_platform_version*: Option[string]
    ch_arch*: Option[string]
    ch_bitness*: Option[string]
    ch_model*: Option[string]
    ch_mobile*: Option[JsonNode]
    disable_spoofing*: Option[string]
    # --- Geolocation spoof ---
    location_mode*: Option[string]
    location_latitude*: Option[string]
    location_longitude*: Option[string]
    location_accuracy*: Option[string]
    user_agent*: Option[string]
    restore_session*: Option[bool]
    low_bandwidth*: Option[bool]
    notes*: Option[string]
    start_url*: Option[string]
    custom_flags*: Option[string]
    status*: Option[string]
    status_machine_id*: Option[string]
    status_heartbeat_at*: Option[string]
    needs_sync*: Option[bool]
    last_pid*: Option[int]
    debug_port*: Option[int]
    tabs_snapshot*: Option[string]
    hidden*: Option[bool]
    trash*: Option[bool]
    deleted_at*: Option[string]
    created_at*: Option[string]
    updated_at*: Option[string]
    last_synced_at*: Option[string]
    s3_key*: Option[string]
    platform*: Option[string]
    resolution*: Option[string]
    locale*: Option[string]
    webrtc*: Option[string]
    geolocation*: Option[string]
    webgl_vendor*: Option[string]
    webgl_renderer*: Option[string]
    canvas*: Option[string]
    webgl*: Option[string]
    audio*: Option[string]
    fonts*: Option[string]
    clientrects*: Option[string]
    webgpu*: Option[string]
    extensions*: Option[string]

  CreateProfileRequest* = object
    name*: Option[string]
    directory_name*: Option[string]
    group_id*: Option[string]
    proxy_id*: Option[string]
    browser_type*: Option[string]
    browser_version*: Option[string]
    os_fingerprint*: Option[string]
    screen_resolution*: Option[string]
    screen_maximizable*: Option[bool]
    language*: Option[string]
    accept_language*: Option[string]
    timezone*: Option[string]
    use_fingerprint*: Option[bool]
    platform_version*: Option[string]
    brand_version*: Option[string]
    engine_version*: Option[string]
    gpu_vendor*: Option[string]
    gpu_model*: Option[string]
    hardware_concurrency*: Option[JsonNode]
    device_memory*: Option[JsonNode]
    device_scale_factor*: Option[JsonNode]
    mobile_model*: Option[string]
    mobile_version*: Option[JsonNode]
    ch_platform*: Option[string]
    ch_platform_version*: Option[string]
    ch_arch*: Option[string]
    ch_bitness*: Option[string]
    ch_model*: Option[string]
    ch_mobile*: Option[JsonNode]
    disable_spoofing*: Option[string]
    location_mode*: Option[string]
    location_latitude*: Option[string]
    location_longitude*: Option[string]
    location_accuracy*: Option[string]
    restore_session*: Option[bool]
    low_bandwidth*: Option[bool]
    notes*: Option[string]
    start_url*: Option[string]
    custom_flags*: Option[string]
    status*: Option[string]
    hidden*: Option[bool]
    user_agent*: Option[string]
    platform*: Option[string]
    resolution*: Option[string]
    locale*: Option[string]
    webrtc*: Option[string]
    geolocation*: Option[string]
    webgl_vendor*: Option[string]
    webgl_renderer*: Option[string]
    canvas*: Option[string]
    webgl*: Option[string]
    audio*: Option[string]
    fonts*: Option[string]
    clientrects*: Option[string]
    webgpu*: Option[string]
    extensions*: Option[string]

  DuplicateProfileRequest* = object
    name*: Option[string]
    group_id*: Option[string]

  CreateProxyRequest* = object
    name*: string
    host*: string
    port*: int
    username*: Option[string]
    password*: Option[string]
    `type`*: Option[string]

  Group* = object
    id*: Option[string]
    name*: Option[string]
    profile_count*: Option[int]
    created_at*: Option[string]
    updated_at*: Option[string]

  CreateGroupRequest* = object
    name*: string

  Extension* = object
    id*: Option[string]
    name*: Option[string]
    path*: Option[string]
    version*: Option[string]
    enabled*: Option[bool]

  Automation* = object
    id*: Option[string]
    name*: Option[string]
    description*: Option[string]
    steps*: Option[string]
    created_at*: Option[string]
    updated_at*: Option[string]

  RunAutomationRequest* = object
    profile_id*: string
    automation_id*: string
    variables*: Option[JsonNode]

  RunAutomationResult* = object
    task_id*: Option[string]
    status*: Option[string]
    started_at*: Option[string]

  StartProfileResponse* = object
    profile_id*: Option[string]
    status*: Option[string]
    ws_endpoint*: Option[string]
    http_endpoint*: Option[string]
    port*: Option[int]

  ApiResponse* = object
    success*: bool
    data*: Option[JsonNode]
    message*: Option[string]
    error*: Option[string]

  GroupListResponse* = object
    groups*: Option[seq[Group]]

  ProfileListResponse* = object
    profiles*: Option[seq[Profile]]

  ExtensionListResponse* = object
    extensions*: Option[seq[Extension]]

  AutomationListResponse* = object
    automations*: Option[seq[Automation]]

proc newProxy*(
  name: string = "",
  host: string = "",
  port: int = 0,
  username: string = "",
  password: string = "",
  `type`: string = ""
): Proxy =
  result = Proxy(
    name: some(name),
    host: some(host),
    port: some(port),
    username: if username.len > 0: some(username) else: none(string),
    password: if password.len > 0: some(password) else: none(string),
    `type`: if `type`.len > 0: some(`type`) else: none(string)
  )

proc newCreateProfileRequest*(name: string): CreateProfileRequest =
  result = CreateProfileRequest(name: some(name))

proc newCreateProxyRequest*(name, host: string, port: int, username: string = "", password: string = "", proxyType: string = ""): CreateProxyRequest =
  result = CreateProxyRequest(
    name: name,
    host: host,
    port: port,
    username: if username.len > 0: some(username) else: none(string),
    password: if password.len > 0: some(password) else: none(string),
    `type`: if proxyType.len > 0: some(proxyType) else: none(string)
  )

proc newCreateGroupRequest*(name: string): CreateGroupRequest =
  result = CreateGroupRequest(name: name)

proc newDuplicateProfileRequest*(name: string = "", groupId: string = ""): DuplicateProfileRequest =
  result = DuplicateProfileRequest(
    name: if name.len > 0: some(name) else: none(string),
    group_id: if groupId.len > 0: some(groupId) else: none(string)
  )

proc newRunAutomationRequest*(profileId, automationId: string): RunAutomationRequest =
  result = RunAutomationRequest(profile_id: profileId, automation_id: automationId)

proc newRunAutomationRequest*(profileId, automationId: string, variables: JsonNode): RunAutomationRequest =
  result = RunAutomationRequest(
    profile_id: profileId,
    automation_id: automationId,
    variables: some(variables)
  )

proc `%`*(p: Proxy): JsonNode =
  result = newJObject()
  if p.name.isSome: result["name"] = %p.name.get()
  if p.host.isSome: result["host"] = %p.host.get()
  if p.port.isSome: result["port"] = %p.port.get()
  if p.username.isSome: result["username"] = %p.username.get()
  if p.password.isSome: result["password"] = %p.password.get()
  if p.`type`.isSome: result["type"] = %p.`type`.get()

proc `%`*(req: CreateProfileRequest): JsonNode =
  result = newJObject()
  if req.name.isSome: result["name"] = %req.name.get()
  if req.directory_name.isSome: result["directoryName"] = %req.directory_name.get()
  if req.group_id.isSome: result["groupId"] = %req.group_id.get()
  if req.proxy_id.isSome: result["proxyId"] = %req.proxy_id.get()
  if req.browser_type.isSome: result["browserType"] = %req.browser_type.get()
  if req.browser_version.isSome: result["browserVersion"] = %req.browser_version.get()
  if req.os_fingerprint.isSome: result["osFingerprint"] = %req.os_fingerprint.get()
  if req.screen_resolution.isSome: result["screenResolution"] = %req.screen_resolution.get()
  if req.screen_maximizable.isSome: result["screenMaximizable"] = %req.screen_maximizable.get()
  if req.language.isSome: result["language"] = %req.language.get()
  if req.accept_language.isSome: result["acceptLanguage"] = %req.accept_language.get()
  if req.timezone.isSome: result["timezone"] = %req.timezone.get()
  if req.use_fingerprint.isSome: result["useFingerprint"] = %req.use_fingerprint.get()
  if req.platform_version.isSome: result["platformVersion"] = %req.platform_version.get()
  if req.brand_version.isSome: result["brandVersion"] = %req.brand_version.get()
  if req.engine_version.isSome: result["engineVersion"] = %req.engine_version.get()
  if req.gpu_vendor.isSome: result["gpuVendor"] = %req.gpu_vendor.get()
  if req.gpu_model.isSome: result["gpuModel"] = %req.gpu_model.get()
  if req.hardware_concurrency.isSome: result["hardwareConcurrency"] = req.hardware_concurrency.get()
  if req.device_memory.isSome: result["deviceMemory"] = req.device_memory.get()
  if req.device_scale_factor.isSome: result["deviceScaleFactor"] = req.device_scale_factor.get()
  if req.mobile_model.isSome: result["mobileModel"] = %req.mobile_model.get()
  if req.mobile_version.isSome: result["mobileVersion"] = req.mobile_version.get()
  if req.ch_platform.isSome: result["chPlatform"] = %req.ch_platform.get()
  if req.ch_platform_version.isSome: result["chPlatformVersion"] = %req.ch_platform_version.get()
  if req.ch_arch.isSome: result["chArch"] = %req.ch_arch.get()
  if req.ch_bitness.isSome: result["chBitness"] = %req.ch_bitness.get()
  if req.ch_model.isSome: result["chModel"] = %req.ch_model.get()
  if req.ch_mobile.isSome: result["chMobile"] = req.ch_mobile.get()
  if req.disable_spoofing.isSome: result["disableSpoofing"] = %req.disable_spoofing.get()
  if req.location_mode.isSome: result["locationMode"] = %req.location_mode.get()
  if req.location_latitude.isSome: result["locationLatitude"] = %req.location_latitude.get()
  if req.location_longitude.isSome: result["locationLongitude"] = %req.location_longitude.get()
  if req.location_accuracy.isSome: result["locationAccuracy"] = %req.location_accuracy.get()
  if req.restore_session.isSome: result["restoreSession"] = %req.restore_session.get()
  if req.low_bandwidth.isSome: result["lowBandwidth"] = %req.low_bandwidth.get()
  if req.notes.isSome: result["notes"] = %req.notes.get()
  if req.start_url.isSome: result["startUrl"] = %req.start_url.get()
  if req.custom_flags.isSome: result["customFlags"] = %req.custom_flags.get()
  if req.status.isSome: result["status"] = %req.status.get()
  if req.hidden.isSome: result["hidden"] = %req.hidden.get()
  if req.user_agent.isSome: result["userAgent"] = %req.user_agent.get()
  if req.platform.isSome: result["platform"] = %req.platform.get()
  if req.resolution.isSome: result["resolution"] = %req.resolution.get()
  if req.locale.isSome: result["locale"] = %req.locale.get()
  if req.webrtc.isSome: result["webrtc"] = %req.webrtc.get()
  if req.geolocation.isSome: result["geolocation"] = %req.geolocation.get()
  if req.webgl_vendor.isSome: result["webgl_vendor"] = %req.webgl_vendor.get()
  if req.webgl_renderer.isSome: result["webgl_renderer"] = %req.webgl_renderer.get()
  if req.canvas.isSome: result["canvas"] = %req.canvas.get()
  if req.webgl.isSome: result["webgl"] = %req.webgl.get()
  if req.audio.isSome: result["audio"] = %req.audio.get()
  if req.fonts.isSome: result["fonts"] = %req.fonts.get()
  if req.clientrects.isSome: result["clientrects"] = %req.clientrects.get()
  if req.webgpu.isSome: result["webgpu"] = %req.webgpu.get()
  if req.extensions.isSome: result["extensions"] = %req.extensions.get()

proc `%`*(req: DuplicateProfileRequest): JsonNode =
  result = newJObject()
  if req.name.isSome: result["name"] = %req.name.get()
  if req.group_id.isSome: result["group_id"] = %req.group_id.get()

proc `%`*(req: CreateProxyRequest): JsonNode =
  result = newJObject()
  result["name"] = %req.name
  result["host"] = %req.host
  result["port"] = %req.port
  if req.username.isSome: result["username"] = %req.username.get()
  if req.password.isSome: result["password"] = %req.password.get()
  if req.`type`.isSome: result["type"] = %req.`type`.get()

proc `%`*(req: CreateGroupRequest): JsonNode =
  result = newJObject()
  result["name"] = %req.name

proc `%`*(req: RunAutomationRequest): JsonNode =
  result = newJObject()
  result["profile_id"] = %req.profile_id
  result["automation_id"] = %req.automation_id
  if req.variables.isSome: result["variables"] = req.variables.get()

proc parseProfile*(json: JsonNode): Profile =
  result = Profile(
    id: if json.hasKey("id"): some(json["id"].getStr()) else: none(string),
    user_id: if json.hasKey("userId"): some(json["userId"].getInt().int) else: none(int),
    user_guid: if json.hasKey("userGuid"): some(json["userGuid"].getStr()) else: none(string),
    name: if json.hasKey("name"): some(json["name"].getStr()) else: none(string),
    directory_name: if json.hasKey("directoryName"): some(json["directoryName"].getStr()) else: none(string),
    group_id: if json.hasKey("groupId"): some(json["groupId"].getStr()) else: none(string),
    proxy_id: if json.hasKey("proxyId"): some(json["proxyId"].getStr()) else: none(string),
    browser_type: if json.hasKey("browserType"): some(json["browserType"].getStr()) else: none(string),
    browser_version: if json.hasKey("browserVersion"): some(json["browserVersion"].getStr()) else: none(string),
    os_fingerprint: if json.hasKey("osFingerprint"): some(json["osFingerprint"].getStr()) else: none(string),
    screen_resolution: if json.hasKey("screenResolution"): some(json["screenResolution"].getStr()) else: none(string),
    screen_maximizable: if json.hasKey("screenMaximizable"): some(json["screenMaximizable"].getBool()) else: none(bool),
    language: if json.hasKey("language"): some(json["language"].getStr()) else: none(string),
    accept_language: if json.hasKey("acceptLanguage"): some(json["acceptLanguage"].getStr()) else: none(string),
    timezone: if json.hasKey("timezone"): some(json["timezone"].getStr()) else: none(string),
    use_fingerprint: if json.hasKey("useFingerprint"): some(json["useFingerprint"].getBool()) else: none(bool),
    fingerprint_id: if json.hasKey("fingerprintId"): some(json["fingerprintId"].getStr()) else: none(string),
    platform_version: if json.hasKey("platformVersion"): some(json["platformVersion"].getStr()) else: none(string),
    brand_version: if json.hasKey("brandVersion"): some(json["brandVersion"].getStr()) else: none(string),
    engine_version: if json.hasKey("engineVersion"): some(json["engineVersion"].getStr()) else: none(string),
    gpu_vendor: if json.hasKey("gpuVendor"): some(json["gpuVendor"].getStr()) else: none(string),
    gpu_model: if json.hasKey("gpuModel"): some(json["gpuModel"].getStr()) else: none(string),
    hardware_concurrency: if json.hasKey("hardwareConcurrency"): some(json["hardwareConcurrency"]) else: none(JsonNode),
    device_memory: if json.hasKey("deviceMemory"): some(json["deviceMemory"]) else: none(JsonNode),
    device_scale_factor: if json.hasKey("deviceScaleFactor"): some(json["deviceScaleFactor"]) else: none(JsonNode),
    mobile_model: if json.hasKey("mobileModel"): some(json["mobileModel"].getStr()) else: none(string),
    mobile_version: if json.hasKey("mobileVersion"): some(json["mobileVersion"]) else: none(JsonNode),
    ch_platform: if json.hasKey("chPlatform"): some(json["chPlatform"].getStr()) else: none(string),
    ch_platform_version: if json.hasKey("chPlatformVersion"): some(json["chPlatformVersion"].getStr()) else: none(string),
    ch_arch: if json.hasKey("chArch"): some(json["chArch"].getStr()) else: none(string),
    ch_bitness: if json.hasKey("chBitness"): some(json["chBitness"].getStr()) else: none(string),
    ch_model: if json.hasKey("chModel"): some(json["chModel"].getStr()) else: none(string),
    ch_mobile: if json.hasKey("chMobile"): some(json["chMobile"]) else: none(JsonNode),
    disable_spoofing: if json.hasKey("disableSpoofing"): some(json["disableSpoofing"].getStr()) else: none(string),
    location_mode: if json.hasKey("locationMode"): some(json["locationMode"].getStr()) else: none(string),
    location_latitude: if json.hasKey("locationLatitude"): some(json["locationLatitude"].getStr()) else: none(string),
    location_longitude: if json.hasKey("locationLongitude"): some(json["locationLongitude"].getStr()) else: none(string),
    location_accuracy: if json.hasKey("locationAccuracy"): some(json["locationAccuracy"].getStr()) else: none(string),
    user_agent: if json.hasKey("userAgent"): some(json["userAgent"].getStr()) else: none(string),
    restore_session: if json.hasKey("restoreSession"): some(json["restoreSession"].getBool()) else: none(bool),
    low_bandwidth: if json.hasKey("lowBandwidth"): some(json["lowBandwidth"].getBool()) else: none(bool),
    notes: if json.hasKey("notes"): some(json["notes"].getStr()) else: none(string),
    start_url: if json.hasKey("startUrl"): some(json["startUrl"].getStr()) else: none(string),
    custom_flags: if json.hasKey("customFlags"): some(json["customFlags"].getStr()) else: none(string),
    status: if json.hasKey("status"): some(json["status"].getStr()) else: none(string),
    status_machine_id: if json.hasKey("statusMachineId"): some(json["statusMachineId"].getStr()) else: none(string),
    status_heartbeat_at: if json.hasKey("statusHeartbeatAt"): some(json["statusHeartbeatAt"].getStr()) else: none(string),
    needs_sync: if json.hasKey("needsSync"): some(json["needsSync"].getBool()) else: none(bool),
    last_pid: if json.hasKey("lastPid"): some(json["lastPid"].getInt().int) else: none(int),
    debug_port: if json.hasKey("debugPort"): some(json["debugPort"].getInt().int) else: none(int),
    tabs_snapshot: if json.hasKey("tabsSnapshot"): some(json["tabsSnapshot"].getStr()) else: none(string),
    hidden: if json.hasKey("hidden"): some(json["hidden"].getBool()) else: none(bool),
    trash: if json.hasKey("trash"): some(json["trash"].getBool()) else: none(bool),
    deleted_at: if json.hasKey("deletedAt"): some(json["deletedAt"].getStr()) else: none(string),
    created_at: if json.hasKey("createdAt"): some(json["createdAt"].getStr()) else: none(string),
    updated_at: if json.hasKey("updatedAt"): some(json["updatedAt"].getStr()) else: none(string),
    last_synced_at: if json.hasKey("lastSyncedAt"): some(json["lastSyncedAt"].getStr()) else: none(string),
    s3_key: if json.hasKey("s3Key"): some(json["s3Key"].getStr()) else: none(string),
    platform: if json.hasKey("platform"): some(json["platform"].getStr()) else: none(string),
    resolution: if json.hasKey("resolution"): some(json["resolution"].getStr()) else: none(string),
    locale: if json.hasKey("locale"): some(json["locale"].getStr()) else: none(string),
    webrtc: if json.hasKey("webrtc"): some(json["webrtc"].getStr()) else: none(string),
    geolocation: if json.hasKey("geolocation"): some(json["geolocation"].getStr()) else: none(string),
    webgl_vendor: if json.hasKey("webgl_vendor"): some(json["webgl_vendor"].getStr()) else: none(string),
    webgl_renderer: if json.hasKey("webgl_renderer"): some(json["webgl_renderer"].getStr()) else: none(string),
    canvas: if json.hasKey("canvas"): some(json["canvas"].getStr()) else: none(string),
    webgl: if json.hasKey("webgl"): some(json["webgl"].getStr()) else: none(string),
    audio: if json.hasKey("audio"): some(json["audio"].getStr()) else: none(string),
    fonts: if json.hasKey("fonts"): some(json["fonts"].getStr()) else: none(string),
    clientrects: if json.hasKey("clientrects"): some(json["clientrects"].getStr()) else: none(string),
    webgpu: if json.hasKey("webgpu"): some(json["webgpu"].getStr()) else: none(string),
    extensions: if json.hasKey("extensions"): some(json["extensions"].getStr()) else: none(string)
  )

proc parseProxy*(json: JsonNode): Proxy =
  result = Proxy(
    id: if json.hasKey("id"): some(json["id"].getStr()) else: none(string),
    name: if json.hasKey("name"): some(json["name"].getStr()) else: none(string),
    host: if json.hasKey("host"): some(json["host"].getStr()) else: none(string),
    port: if json.hasKey("port"): some(json["port"].getInt().int) else: none(int),
    username: if json.hasKey("username"): some(json["username"].getStr()) else: none(string),
    password: if json.hasKey("password"): some(json["password"].getStr()) else: none(string),
    `type`: if json.hasKey("type"): some(json["type"].getStr()) else: none(string)
  )

proc parseGroup*(json: JsonNode): Group =
  result = Group(
    id: if json.hasKey("id"): some(json["id"].getStr()) else: none(string),
    name: if json.hasKey("name"): some(json["name"].getStr()) else: none(string),
    profile_count: if json.hasKey("profile_count"): some(json["profile_count"].getInt().int) else: none(int),
    created_at: if json.hasKey("created_at"): some(json["created_at"].getStr()) else: none(string),
    updated_at: if json.hasKey("updated_at"): some(json["updated_at"].getStr()) else: none(string)
  )

proc parseExtension*(json: JsonNode): Extension =
  result = Extension(
    id: if json.hasKey("id"): some(json["id"].getStr()) else: none(string),
    name: if json.hasKey("name"): some(json["name"].getStr()) else: none(string),
    path: if json.hasKey("path"): some(json["path"].getStr()) else: none(string),
    version: if json.hasKey("version"): some(json["version"].getStr()) else: none(string),
    enabled: if json.hasKey("enabled"): some(json["enabled"].getBool()) else: none(bool)
  )

proc parseAutomation*(json: JsonNode): Automation =
  result = Automation(
    id: if json.hasKey("id"): some(json["id"].getStr()) else: none(string),
    name: if json.hasKey("name"): some(json["name"].getStr()) else: none(string),
    description: if json.hasKey("description"): some(json["description"].getStr()) else: none(string),
    steps: if json.hasKey("steps"): some(json["steps"].getStr()) else: none(string),
    created_at: if json.hasKey("created_at"): some(json["created_at"].getStr()) else: none(string),
    updated_at: if json.hasKey("updated_at"): some(json["updated_at"].getStr()) else: none(string)
  )

proc parseStartProfileResponse*(json: JsonNode): StartProfileResponse =
  result = StartProfileResponse(
    profile_id: if json.hasKey("profile_id"): some(json["profile_id"].getStr()) else: none(string),
    status: if json.hasKey("status"): some(json["status"].getStr()) else: none(string),
    ws_endpoint: if json.hasKey("ws_endpoint"): some(json["ws_endpoint"].getStr()) else: none(string),
    http_endpoint: if json.hasKey("http_endpoint"): some(json["http_endpoint"].getStr()) else: none(string),
    port: if json.hasKey("port"): some(json["port"].getInt().int) else: none(int)
  )

proc parseApiResponse*(json: JsonNode): ApiResponse =
  result = ApiResponse(
    success: json.hasKey("success") and json["success"].getBool(),
    data: if json.hasKey("data"): some(json["data"]) else: none(JsonNode),
    message: if json.hasKey("message"): some(json["message"].getStr()) else: none(string),
    error: if json.hasKey("error"): some(json["error"].getStr()) else: none(string)
  )

proc parseRunAutomationResult*(json: JsonNode): RunAutomationResult =
  result = RunAutomationResult(
    task_id: if json.hasKey("task_id"): some(json["task_id"].getStr()) else: none(string),
    status: if json.hasKey("status"): some(json["status"].getStr()) else: none(string),
    started_at: if json.hasKey("started_at"): some(json["started_at"].getStr()) else: none(string)
  )
