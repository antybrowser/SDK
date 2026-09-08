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
    name*: Option[string]
    group_id*: Option[string]
    proxy_id*: Option[string]
    user_agent*: Option[string]
    language*: Option[string]
    platform*: Option[string]
    resolution*: Option[string]
    timezone*: Option[string]
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
    notes*: Option[string]
    start_url*: Option[string]
    created_at*: Option[string]
    updated_at*: Option[string]

  CreateProfileRequest* = object
    name*: Option[string]
    group_id*: Option[string]
    proxy_id*: Option[string]
    user_agent*: Option[string]
    language*: Option[string]
    platform*: Option[string]
    resolution*: Option[string]
    timezone*: Option[string]
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
    notes*: Option[string]
    start_url*: Option[string]

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

  ProxyCheckResult* = object
    ip*: Option[string]
    country*: Option[string]
    country_code*: Option[string]
    city*: Option[string]
    latitude*: Option[string]
    longitude*: Option[string]
    timezone*: Option[string]
    isp*: Option[string]
    org*: Option[string]
    as_num*: Option[string]
    proxy*: Option[bool]
    secured*: Option[bool]

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

  Settings* = object
    font_block_list*: Option[string]
    canvas_noise*: Option[bool]
    webgl_noise*: Option[bool]
    audio_noise*: Option[bool]
    clientrects_noise*: Option[bool]

  SyncStatus* = object
    status*: Option[string]
    last_sync*: Option[string]
    synced_profiles*: Option[int]

  StatusResponse* = object
    status*: Option[string]
    version*: Option[string]
    port*: Option[int]

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
  if req.group_id.isSome: result["group_id"] = %req.group_id.get()
  if req.proxy_id.isSome: result["proxy_id"] = %req.proxy_id.get()
  if req.user_agent.isSome: result["user_agent"] = %req.user_agent.get()
  if req.language.isSome: result["language"] = %req.language.get()
  if req.platform.isSome: result["platform"] = %req.platform.get()
  if req.resolution.isSome: result["resolution"] = %req.resolution.get()
  if req.timezone.isSome: result["timezone"] = %req.timezone.get()
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
  if req.notes.isSome: result["notes"] = %req.notes.get()
  if req.start_url.isSome: result["start_url"] = %req.start_url.get()

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

proc `%`*(settings: Settings): JsonNode =
  result = newJObject()
  if settings.font_block_list.isSome: result["font_block_list"] = %settings.font_block_list.get()
  if settings.canvas_noise.isSome: result["canvas_noise"] = %settings.canvas_noise.get()
  if settings.webgl_noise.isSome: result["webgl_noise"] = %settings.webgl_noise.get()
  if settings.audio_noise.isSome: result["audio_noise"] = %settings.audio_noise.get()
  if settings.clientrects_noise.isSome: result["clientrects_noise"] = %settings.clientrects_noise.get()

proc parseProfile*(json: JsonNode): Profile =
  result = Profile(
    id: if json.hasKey("id"): some(json["id"].getStr()) else: none(string),
    name: if json.hasKey("name"): some(json["name"].getStr()) else: none(string),
    group_id: if json.hasKey("group_id"): some(json["group_id"].getStr()) else: none(string),
    proxy_id: if json.hasKey("proxy_id"): some(json["proxy_id"].getStr()) else: none(string),
    user_agent: if json.hasKey("user_agent"): some(json["user_agent"].getStr()) else: none(string),
    language: if json.hasKey("language"): some(json["language"].getStr()) else: none(string),
    platform: if json.hasKey("platform"): some(json["platform"].getStr()) else: none(string),
    resolution: if json.hasKey("resolution"): some(json["resolution"].getStr()) else: none(string),
    timezone: if json.hasKey("timezone"): some(json["timezone"].getStr()) else: none(string),
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
    extensions: if json.hasKey("extensions"): some(json["extensions"].getStr()) else: none(string),
    notes: if json.hasKey("notes"): some(json["notes"].getStr()) else: none(string),
    start_url: if json.hasKey("start_url"): some(json["start_url"].getStr()) else: none(string),
    created_at: if json.hasKey("created_at"): some(json["created_at"].getStr()) else: none(string),
    updated_at: if json.hasKey("updated_at"): some(json["updated_at"].getStr()) else: none(string)
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

proc parseProxyCheckResult*(json: JsonNode): ProxyCheckResult =
  result = ProxyCheckResult(
    ip: if json.hasKey("ip"): some(json["ip"].getStr()) else: none(string),
    country: if json.hasKey("country"): some(json["country"].getStr()) else: none(string),
    country_code: if json.hasKey("country_code"): some(json["country_code"].getStr()) else: none(string),
    city: if json.hasKey("city"): some(json["city"].getStr()) else: none(string),
    latitude: if json.hasKey("latitude"): some(json["latitude"].getStr()) else: none(string),
    longitude: if json.hasKey("longitude"): some(json["longitude"].getStr()) else: none(string),
    timezone: if json.hasKey("timezone"): some(json["timezone"].getStr()) else: none(string),
    isp: if json.hasKey("isp"): some(json["isp"].getStr()) else: none(string),
    org: if json.hasKey("org"): some(json["org"].getStr()) else: none(string),
    as_num: if json.hasKey("as_num"): some(json["as_num"].getStr()) else: none(string),
    proxy: if json.hasKey("proxy"): some(json["proxy"].getBool()) else: none(bool),
    secured: if json.hasKey("secured"): some(json["secured"].getBool()) else: none(bool)
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

proc parseSettings*(json: JsonNode): Settings =
  result = Settings(
    font_block_list: if json.hasKey("font_block_list"): some(json["font_block_list"].getStr()) else: none(string),
    canvas_noise: if json.hasKey("canvas_noise"): some(json["canvas_noise"].getBool()) else: none(bool),
    webgl_noise: if json.hasKey("webgl_noise"): some(json["webgl_noise"].getBool()) else: none(bool),
    audio_noise: if json.hasKey("audio_noise"): some(json["audio_noise"].getBool()) else: none(bool),
    clientrects_noise: if json.hasKey("clientrects_noise"): some(json["clientrects_noise"].getBool()) else: none(bool)
  )

proc parseSyncStatus*(json: JsonNode): SyncStatus =
  result = SyncStatus(
    status: if json.hasKey("status"): some(json["status"].getStr()) else: none(string),
    last_sync: if json.hasKey("last_sync"): some(json["last_sync"].getStr()) else: none(string),
    synced_profiles: if json.hasKey("synced_profiles"): some(json["synced_profiles"].getInt().int) else: none(int)
  )

proc parseStatusResponse*(json: JsonNode): StatusResponse =
  result = StatusResponse(
    status: if json.hasKey("status"): some(json["status"].getStr()) else: none(string),
    version: if json.hasKey("version"): some(json["version"].getStr()) else: none(string),
    port: if json.hasKey("port"): some(json["port"].getInt().int) else: none(int)
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
