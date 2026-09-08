import std/httpclient
import std/asyncdispatch
import std/json
import std/uri
import std/options
import ./types
import ./error

type
  AntybrowserClient* = ref object
    apiKey*: string
    baseUrl*: string
    timeout*: int

proc newAntybrowserClient*(apiKey: string, port: int = 5173, baseUrl: string = "", timeout: int = 30000): AntybrowserClient =
  let base = if baseUrl.len > 0: baseUrl else: "http://127.0.0.1:" & $port
  result = AntybrowserClient(apiKey: apiKey, baseUrl: base, timeout: timeout)

proc request(client: AntybrowserClient, httpMethod: string, path: string, body: JsonNode = nil): Future[JsonNode] {.async.} =
  let url = client.baseUrl & path
  var headers = newHttpHeaders()
  headers["x-api-key"] = client.apiKey
  headers["Content-Type"] = "application/json"

  var clientHttp = newAsyncHttpClient()
  clientHttp.headers = headers
  clientHttp.timeout = client.timeout

  try:
    var response: AsyncResponse
    case httpMethod
    of "GET":
      response = await clientHttp.get(url)
    of "POST":
      let bodyStr = if body != nil: $body else: "{}"
      response = await clientHttp.post(url, body = bodyStr)
    of "PUT":
      let bodyStr = if body != nil: $body else: "{}"
      response = await clientHttp.request(url, httpMethod = HttpPut, body = bodyStr)
    of "DELETE":
      response = await clientHttp.delete(url)
    else:
      raise newException(ValueError, "Unsupported HTTP method: " & httpMethod)

    let responseBody = await response.body
    let code = response.code

    if code >= 200 and code < 300:
      if responseBody.len == 0:
        return newJObject()
      return parseJson(responseBody)
    else:
      raise newAntybrowserError("HTTP " & $code & ": " & responseBody, code.int, responseBody)
  except CatchableError as e:
    if e of AntybrowserError:
      raise e
    raise newAntybrowserError(e.msg, -1, "")
  finally:
    clientHttp.close()

proc get(client: AntybrowserClient, path: string): Future[JsonNode] {.async.} =
  return await client.request("GET", path)

proc post(client: AntybrowserClient, path: string, body: JsonNode = nil): Future[JsonNode] {.async.} =
  return await client.request("POST", path, body)

proc put(client: AntybrowserClient, path: string, body: JsonNode = nil): Future[JsonNode] {.async.} =
  return await client.request("PUT", path, body)

proc deleteRequest(client: AntybrowserClient, path: string): Future[JsonNode] {.async.} =
  return await client.request("DELETE", path)

# Status / General
proc getStatus*(client: AntybrowserClient): Future[StatusResponse] {.async.} =
  let resp = await client.get("/api/status")
  return parseStatusResponse(resp)

# Profiles
proc listProfiles*(client: AntybrowserClient): Future[seq[Profile]] {.async.} =
  let resp = await client.get("/api/profiles")
  result = @[]
  if resp.hasKey("data") and resp["data"].kind == JArray:
    for item in resp["data"]:
      result.add(parseProfile(item))

proc getProfile*(client: AntybrowserClient, profileId: string): Future[Profile] {.async.} =
  let resp = await client.get("/api/profiles/" & profileId)
  if resp.hasKey("data"):
    return parseProfile(resp["data"])
  return parseProfile(resp)

proc createProfile*(client: AntybrowserClient, request: CreateProfileRequest): Future[Profile] {.async.} =
  let resp = await client.post("/api/profiles", %request)
  if resp.hasKey("data"):
    return parseProfile(resp["data"])
  return parseProfile(resp)

proc updateProfile*(client: AntybrowserClient, profileId: string, request: CreateProfileRequest): Future[Profile] {.async.} =
  let resp = await client.put("/api/profiles/" & profileId, %request)
  if resp.hasKey("data"):
    return parseProfile(resp["data"])
  return parseProfile(resp)

proc deleteProfile*(client: AntybrowserClient, profileId: string): Future[ApiResponse] {.async.} =
  let resp = await client.deleteRequest("/api/profiles/" & profileId)
  return parseApiResponse(resp)

proc duplicateProfile*(client: AntybrowserClient, profileId: string, request: DuplicateProfileRequest): Future[Profile] {.async.} =
  let resp = await client.post("/api/profiles/" & profileId & "/duplicate", %request)
  if resp.hasKey("data"):
    return parseProfile(resp["data"])
  return parseProfile(resp)

proc startProfile*(client: AntybrowserClient, profileId: string): Future[StartProfileResponse] {.async.} =
  let resp = await client.post("/api/profiles/" & profileId & "/start")
  if resp.hasKey("data"):
    return parseStartProfileResponse(resp["data"])
  return parseStartProfileResponse(resp)

proc stopProfile*(client: AntybrowserClient, profileId: string): Future[ApiResponse] {.async.} =
  let resp = await client.post("/api/profiles/" & profileId & "/stop")
  return parseApiResponse(resp)

proc getProfileFingerprint*(client: AntybrowserClient, profileId: string): Future[JsonNode] {.async.} =
  let resp = await client.get("/api/profiles/" & profileId & "/fingerprint")
  if resp.hasKey("data"):
    return resp["data"]
  return resp

# Proxies
proc listProxies*(client: AntybrowserClient): Future[seq[Proxy]] {.async.} =
  let resp = await client.get("/api/proxies")
  result = @[]
  if resp.hasKey("data") and resp["data"].kind == JArray:
    for item in resp["data"]:
      result.add(parseProxy(item))

proc getProxy*(client: AntybrowserClient, proxyId: string): Future[Proxy] {.async.} =
  let resp = await client.get("/api/proxies/" & proxyId)
  if resp.hasKey("data"):
    return parseProxy(resp["data"])
  return parseProxy(resp)

proc createProxy*(client: AntybrowserClient, request: CreateProxyRequest): Future[Proxy] {.async.} =
  let resp = await client.post("/api/proxies", %request)
  if resp.hasKey("data"):
    return parseProxy(resp["data"])
  return parseProxy(resp)

proc deleteProxy*(client: AntybrowserClient, proxyId: string): Future[ApiResponse] {.async.} =
  let resp = await client.deleteRequest("/api/proxies/" & proxyId)
  return parseApiResponse(resp)

proc checkProxy*(client: AntybrowserClient, proxyId: string): Future[ProxyCheckResult] {.async.} =
  let resp = await client.post("/api/proxies/" & proxyId & "/check")
  if resp.hasKey("data"):
    return parseProxyCheckResult(resp["data"])
  return parseProxyCheckResult(resp)

# Groups
proc listGroups*(client: AntybrowserClient): Future[seq[Group]] {.async.} =
  let resp = await client.get("/api/groups")
  result = @[]
  if resp.hasKey("data") and resp["data"].kind == JArray:
    for item in resp["data"]:
      result.add(parseGroup(item))

proc getGroup*(client: AntybrowserClient, groupId: string): Future[Group] {.async.} =
  let resp = await client.get("/api/groups/" & groupId)
  if resp.hasKey("data"):
    return parseGroup(resp["data"])
  return parseGroup(resp)

proc createGroup*(client: AntybrowserClient, request: CreateGroupRequest): Future[Group] {.async.} =
  let resp = await client.post("/api/groups", %request)
  if resp.hasKey("data"):
    return parseGroup(resp["data"])
  return parseGroup(resp)

proc updateGroup*(client: AntybrowserClient, groupId: string, request: CreateGroupRequest): Future[Group] {.async.} =
  let resp = await client.put("/api/groups/" & groupId, %request)
  if resp.hasKey("data"):
    return parseGroup(resp["data"])
  return parseGroup(resp)

proc deleteGroup*(client: AntybrowserClient, groupId: string): Future[ApiResponse] {.async.} =
  let resp = await client.deleteRequest("/api/groups/" & groupId)
  return parseApiResponse(resp)

# Extensions
proc listExtensions*(client: AntybrowserClient): Future[seq[Extension]] {.async.} =
  let resp = await client.get("/api/extensions")
  result = @[]
  if resp.hasKey("data") and resp["data"].kind == JArray:
    for item in resp["data"]:
      result.add(parseExtension(item))

proc installExtension*(client: AntybrowserClient, profileId: string, extensionPath: string): Future[ApiResponse] {.async.} =
  let body = %{"profile_id": %profileId, "path": %extensionPath}
  let resp = await client.post("/api/extensions/install", body)
  return parseApiResponse(resp)

proc uninstallExtension*(client: AntybrowserClient, profileId: string, extensionId: string): Future[ApiResponse] {.async.} =
  let body = %{"profile_id": %profileId, "extension_id": %extensionId}
  let resp = await client.post("/api/extensions/uninstall", body)
  return parseApiResponse(resp)

# Automations
proc listAutomations*(client: AntybrowserClient): Future[seq[Automation]] {.async.} =
  let resp = await client.get("/api/automations")
  result = @[]
  if resp.hasKey("data") and resp["data"].kind == JArray:
    for item in resp["data"]:
      result.add(parseAutomation(item))

proc runAutomation*(client: AntybrowserClient, request: RunAutomationRequest): Future[RunAutomationResult] {.async.} =
  let resp = await client.post("/api/automations/run", %request)
  if resp.hasKey("data"):
    return parseRunAutomationResult(resp["data"])
  return parseRunAutomationResult(resp)

# Settings
proc getSettings*(client: AntybrowserClient): Future[Settings] {.async.} =
  let resp = await client.get("/api/settings")
  if resp.hasKey("data"):
    return parseSettings(resp["data"])
  return parseSettings(resp)

proc updateSettings*(client: AntybrowserClient, settings: Settings): Future[Settings] {.async.} =
  let resp = await client.put("/api/settings", %settings)
  if resp.hasKey("data"):
    return parseSettings(resp["data"])
  return parseSettings(resp)

# Sync
proc getSyncStatus*(client: AntybrowserClient): Future[SyncStatus] {.async.} =
  let resp = await client.get("/api/sync/status")
  if resp.hasKey("data"):
    return parseSyncStatus(resp["data"])
  return parseSyncStatus(resp)

proc triggerSync*(client: AntybrowserClient): Future[ApiResponse] {.async.} =
  let resp = await client.post("/api/sync/trigger")
  return parseApiResponse(resp)
