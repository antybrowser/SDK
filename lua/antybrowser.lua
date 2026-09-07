local json = require("cjson")
local http = require("socket.http")
local ltn12 = require("ltn12")

local M = {}
M.__index = M

function M.new(api_key, opts)
    opts = opts or {}
    local self = setmetatable({}, M)
    self.api_key = api_key
    self.base_url = opts.base_url or ("http://127.0.0.1:" .. (opts.port or 5173))
    return self
end

local function request(self, method, path, body)
    local url = self.base_url .. path
    local resp_body = {}
    local req = {
        url = url,
        method = method,
        headers = {
            ["x-api-key"] = self.api_key,
            ["Content-Type"] = "application/json",
        },
        sink = ltn12.sink.table(resp_body),
    }
    if body then
        req.source = ltn12.source.string(json.encode(body))
    end
    local res, code, headers, status = http.request(req)
    local raw = table.concat(resp_body)
    if code < 200 or code >= 300 then
        return nil, "HTTP " .. code .. ": " .. raw
    end
    return json.decode(raw)
end

-- System
function M:get_status() return request(self, "GET", "/api/status") end
function M:get_settings() return request(self, "GET", "/api/settings") end
function M:get_sync_status() return request(self, "GET", "/api/sync/status") end

function M:refresh_sync(profile_id)
    local body = profile_id and { profileId = profile_id } or {}
    return request(self, "POST", "/api/sync/refresh", body)
end

-- Profiles
function M:get_profiles() return request(self, "GET", "/api/profiles") end
function M:create_profile(data) return request(self, "POST", "/api/profiles", data) end
function M:update_profile(id, data) return request(self, "PUT", "/api/profiles/" .. id, data) end
function M:delete_profile(id) return request(self, "DELETE", "/api/profiles/" .. id) end
function M:start_profile(id) return request(self, "POST", "/api/profiles/" .. id .. "/start") end
function M:stop_profile(id) return request(self, "POST", "/api/profiles/" .. id .. "/stop") end
function M:duplicate_profile(id, name)
    return request(self, "POST", "/api/profiles/" .. id .. "/duplicate", name and { name = name } or nil)
end

-- Automations
function M:get_automations() return request(self, "GET", "/api/automations") end
function M:run_automation(id, profile_id)
    return request(self, "POST", "/api/automations/" .. id .. "/run", { profileId = profile_id })
end

-- Groups
function M:get_groups() return request(self, "GET", "/api/groups") end
function M:create_group(data) return request(self, "POST", "/api/groups", data) end
function M:update_group(id, data) return request(self, "PUT", "/api/groups/" .. id, data) end
function M:delete_group(id) return request(self, "DELETE", "/api/groups/" .. id) end

-- Proxies
function M:get_proxies() return request(self, "GET", "/api/proxies") end
function M:create_proxy(data) return request(self, "POST", "/api/proxies", data) end
function M:check_proxy(data) return request(self, "POST", "/api/proxies/check", data) end
function M:delete_proxy(id) return request(self, "DELETE", "/api/proxies/" .. id) end

-- Extensions
function M:get_extensions() return request(self, "GET", "/api/extensions") end
function M:delete_extension(id) return request(self, "DELETE", "/api/extensions/" .. id) end
function M:get_profile_extensions(profile_id) return request(self, "GET", "/api/profiles/" .. profile_id .. "/extensions") end
function M:set_profile_extensions(profile_id, extension_ids)
    return request(self, "POST", "/api/profiles/" .. profile_id .. "/extensions", { extensionIds = extension_ids })
end

return M
