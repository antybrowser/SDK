#pragma once

#include <algorithm>
#include <nlohmann/json.hpp>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

namespace antybrowser {

using json = nlohmann::json;

// ─── Profile ───────────────────────────────────────────────────────────────

struct Profile {
    int id;
    std::string name;
    std::optional<std::string> directory_name;
    std::optional<int> group_id;
    std::optional<int> proxy_id;
    std::optional<std::string> browser_type;
    std::optional<std::string> browser_version;
    std::optional<std::string> os_fingerprint;
    std::optional<std::string> screen_resolution;
    std::optional<std::string> language;
    std::optional<std::string> accept_language;
    std::optional<std::string> timezone;
    std::optional<bool> use_fingerprint;
    std::optional<std::string> fingerprint_id;
    std::optional<bool> restore_session;
    std::optional<bool> low_bandwidth;
    std::optional<std::string> notes;
    std::optional<std::string> start_url;
    std::optional<std::string> custom_flags;
    std::optional<std::string> status;
    std::optional<bool> needs_sync;
    std::optional<int> last_pid;
    std::optional<int> debug_port;
    std::optional<std::string> created_at;
    std::optional<std::string> updated_at;
    std::optional<std::string> last_synced_at;
    std::optional<std::string> s3_key;
    std::optional<bool> trash;
    std::optional<std::string> deleted_at;
    std::optional<bool> hidden;
    std::unordered_map<std::string, json> extra;
};

inline void from_json(const json& j, Profile& p) {
    j.at("id").get_to(p.id);
    j.at("name").get_to(p.name);
    if (j.contains("directoryName")) p.directory_name = j["directoryName"].get<std::string>();
    if (j.contains("groupId")) p.group_id = j["groupId"].get<int>();
    if (j.contains("proxyId")) p.proxy_id = j["proxyId"].get<int>();
    if (j.contains("browserType")) p.browser_type = j["browserType"].get<std::string>();
    if (j.contains("browserVersion")) p.browser_version = j["browserVersion"].get<std::string>();
    if (j.contains("osFingerprint")) p.os_fingerprint = j["osFingerprint"].get<std::string>();
    if (j.contains("screenResolution")) p.screen_resolution = j["screenResolution"].get<std::string>();
    if (j.contains("language")) p.language = j["language"].get<std::string>();
    if (j.contains("acceptLanguage")) p.accept_language = j["acceptLanguage"].get<std::string>();
    if (j.contains("timezone")) p.timezone = j["timezone"].get<std::string>();
    if (j.contains("useFingerprint")) p.use_fingerprint = j["useFingerprint"].get<bool>();
    if (j.contains("fingerprintId")) p.fingerprint_id = j["fingerprintId"].get<std::string>();
    if (j.contains("restoreSession")) p.restore_session = j["restoreSession"].get<bool>();
    if (j.contains("lowBandwidth")) p.low_bandwidth = j["lowBandwidth"].get<bool>();
    if (j.contains("notes")) p.notes = j["notes"].get<std::string>();
    if (j.contains("startUrl")) p.start_url = j["startUrl"].get<std::string>();
    if (j.contains("customFlags")) p.custom_flags = j["customFlags"].get<std::string>();
    if (j.contains("status")) p.status = j["status"].get<std::string>();
    if (j.contains("needsSync")) p.needs_sync = j["needsSync"].get<bool>();
    if (j.contains("lastPid")) p.last_pid = j["lastPid"].get<int>();
    if (j.contains("debugPort")) p.debug_port = j["debugPort"].get<int>();
    if (j.contains("createdAt")) p.created_at = j["createdAt"].get<std::string>();
    if (j.contains("updatedAt")) p.updated_at = j["updatedAt"].get<std::string>();
    if (j.contains("lastSyncedAt")) p.last_synced_at = j["lastSyncedAt"].get<std::string>();
    if (j.contains("s3Key")) p.s3_key = j["s3Key"].get<std::string>();
    if (j.contains("trash")) p.trash = j["trash"].get<bool>();
    if (j.contains("deletedAt")) p.deleted_at = j["deletedAt"].get<std::string>();
    if (j.contains("hidden")) p.hidden = j["hidden"].get<bool>();

    static const std::vector<std::string> known = {
        "id", "name", "directoryName", "groupId", "proxyId", "browserType",
        "browserVersion", "osFingerprint", "screenResolution", "language",
        "acceptLanguage", "timezone", "useFingerprint", "fingerprintId",
        "restoreSession", "lowBandwidth", "notes", "startUrl", "customFlags",
        "status", "needsSync", "lastPid", "debugPort", "createdAt", "updatedAt",
        "lastSyncedAt", "s3Key", "trash", "deletedAt", "hidden"
    };
    for (auto& [key, val] : j.items()) {
        if (std::find(known.begin(), known.end(), key) == known.end()) {
            p.extra[key] = val;
        }
    }
}

inline void to_json(json& j, const Profile& p) {
    j = json{{"id", p.id}, {"name", p.name}};
    if (p.directory_name) j["directoryName"] = *p.directory_name;
    if (p.group_id) j["groupId"] = *p.group_id;
    if (p.proxy_id) j["proxyId"] = *p.proxy_id;
    if (p.browser_type) j["browserType"] = *p.browser_type;
    if (p.browser_version) j["browserVersion"] = *p.browser_version;
    if (p.os_fingerprint) j["osFingerprint"] = *p.os_fingerprint;
    if (p.screen_resolution) j["screenResolution"] = *p.screen_resolution;
    if (p.language) j["language"] = *p.language;
    if (p.accept_language) j["acceptLanguage"] = *p.accept_language;
    if (p.timezone) j["timezone"] = *p.timezone;
    if (p.use_fingerprint) j["useFingerprint"] = *p.use_fingerprint;
    if (p.fingerprint_id) j["fingerprintId"] = *p.fingerprint_id;
    if (p.restore_session) j["restoreSession"] = *p.restore_session;
    if (p.low_bandwidth) j["lowBandwidth"] = *p.low_bandwidth;
    if (p.notes) j["notes"] = *p.notes;
    if (p.start_url) j["startUrl"] = *p.start_url;
    if (p.custom_flags) j["customFlags"] = *p.custom_flags;
    if (p.status) j["status"] = *p.status;
    if (p.needs_sync) j["needsSync"] = *p.needs_sync;
    if (p.last_pid) j["lastPid"] = *p.last_pid;
    if (p.debug_port) j["debugPort"] = *p.debug_port;
    if (p.created_at) j["createdAt"] = *p.created_at;
    if (p.updated_at) j["updatedAt"] = *p.updated_at;
    if (p.last_synced_at) j["lastSyncedAt"] = *p.last_synced_at;
    if (p.s3_key) j["s3Key"] = *p.s3_key;
    if (p.trash) j["trash"] = *p.trash;
    if (p.deleted_at) j["deletedAt"] = *p.deleted_at;
    if (p.hidden) j["hidden"] = *p.hidden;
    for (auto& [key, val] : p.extra) {
        j[key] = val;
    }
}

// ─── CreateProfileRequest ──────────────────────────────────────────────────

struct CreateProfileRequest {
    std::string name;
    std::optional<std::string> directory_name;
    std::optional<int> group_id;
    std::optional<int> proxy_id;
    std::optional<std::string> browser_type;
    std::optional<std::string> os_fingerprint;
    std::optional<std::string> screen_resolution;
    std::optional<std::string> language;
    std::optional<std::string> accept_language;
    std::optional<std::string> timezone;
    std::optional<bool> use_fingerprint;
    std::optional<std::string> fingerprint_id;
    std::optional<bool> restore_session;
    std::optional<bool> low_bandwidth;
    std::optional<std::string> notes;
    std::optional<std::string> start_url;
    std::optional<std::string> custom_flags;
};

inline void to_json(json& j, const CreateProfileRequest& r) {
    j = json{{"name", r.name}};
    if (r.directory_name) j["directoryName"] = *r.directory_name;
    if (r.group_id) j["groupId"] = *r.group_id;
    if (r.proxy_id) j["proxyId"] = *r.proxy_id;
    if (r.browser_type) j["browserType"] = *r.browser_type;
    if (r.os_fingerprint) j["osFingerprint"] = *r.os_fingerprint;
    if (r.screen_resolution) j["screenResolution"] = *r.screen_resolution;
    if (r.language) j["language"] = *r.language;
    if (r.accept_language) j["acceptLanguage"] = *r.accept_language;
    if (r.timezone) j["timezone"] = *r.timezone;
    if (r.use_fingerprint) j["useFingerprint"] = *r.use_fingerprint;
    if (r.fingerprint_id) j["fingerprintId"] = *r.fingerprint_id;
    if (r.restore_session) j["restoreSession"] = *r.restore_session;
    if (r.low_bandwidth) j["lowBandwidth"] = *r.low_bandwidth;
    if (r.notes) j["notes"] = *r.notes;
    if (r.start_url) j["startUrl"] = *r.start_url;
    if (r.custom_flags) j["customFlags"] = *r.custom_flags;
}

// ─── Proxy ─────────────────────────────────────────────────────────────────

struct Proxy {
    int id;
    std::optional<std::string> name;
    std::optional<std::string> type;
    std::optional<std::string> host;
    std::optional<int> port;
    std::optional<std::string> username;
    std::optional<std::string> password;
    std::optional<std::string> status;
    std::optional<std::string> country_code;
    std::optional<std::string> ip;
    std::optional<std::string> country;
    std::optional<std::string> timezone;
    std::optional<std::string> asn;
    std::optional<std::string> isp;
    std::unordered_map<std::string, json> extra;
};

inline void from_json(const json& j, Proxy& p) {
    j.at("id").get_to(p.id);
    if (j.contains("name")) p.name = j["name"].get<std::string>();
    if (j.contains("type")) p.type = j["type"].get<std::string>();
    if (j.contains("host")) p.host = j["host"].get<std::string>();
    if (j.contains("port")) p.port = j["port"].get<int>();
    if (j.contains("username")) p.username = j["username"].get<std::string>();
    if (j.contains("password")) p.password = j["password"].get<std::string>();
    if (j.contains("status")) p.status = j["status"].get<std::string>();
    if (j.contains("countryCode")) p.country_code = j["countryCode"].get<std::string>();
    if (j.contains("ip")) p.ip = j["ip"].get<std::string>();
    if (j.contains("country")) p.country = j["country"].get<std::string>();
    if (j.contains("timezone")) p.timezone = j["timezone"].get<std::string>();
    if (j.contains("asn")) p.asn = j["asn"].get<std::string>();
    if (j.contains("isp")) p.isp = j["isp"].get<std::string>();

    static const std::vector<std::string> known = {
        "id", "name", "type", "host", "port", "username", "password",
        "status", "countryCode", "ip", "country", "timezone", "asn", "isp"
    };
    for (auto& [key, val] : j.items()) {
        if (std::find(known.begin(), known.end(), key) == known.end()) {
            p.extra[key] = val;
        }
    }
}

inline void to_json(json& j, const Proxy& p) {
    j = json{{"id", p.id}};
    if (p.name) j["name"] = *p.name;
    if (p.type) j["type"] = *p.type;
    if (p.host) j["host"] = *p.host;
    if (p.port) j["port"] = *p.port;
    if (p.username) j["username"] = *p.username;
    if (p.password) j["password"] = *p.password;
    if (p.status) j["status"] = *p.status;
    if (p.country_code) j["countryCode"] = *p.country_code;
    if (p.ip) j["ip"] = *p.ip;
    if (p.country) j["country"] = *p.country;
    if (p.timezone) j["timezone"] = *p.timezone;
    if (p.asn) j["asn"] = *p.asn;
    if (p.isp) j["isp"] = *p.isp;
    for (auto& [key, val] : p.extra) {
        j[key] = val;
    }
}

// ─── CreateProxyRequest ────────────────────────────────────────────────────

struct CreateProxyRequest {
    std::string name;
    std::string host;
    int port;
    std::string type;
    std::optional<std::string> username;
    std::optional<std::string> password;
};

inline void to_json(json& j, const CreateProxyRequest& r) {
    j = json{
        {"name", r.name},
        {"host", r.host},
        {"port", r.port},
        {"type", r.type}
    };
    if (r.username) j["username"] = *r.username;
    if (r.password) j["password"] = *r.password;
}

// ─── ProxyCheckResult ──────────────────────────────────────────────────────

struct ProxyCheckResult {
    bool success;
    std::optional<std::unordered_map<std::string, json>> details;
    std::optional<std::string> error_message;
};

inline void from_json(const json& j, ProxyCheckResult& r) {
    if (j.contains("success")) r.success = j["success"].get<bool>();
    else r.success = false;
    if (j.contains("details")) r.details = j["details"].get<std::unordered_map<std::string, json>>();
    if (j.contains("errorMessage")) r.error_message = j["errorMessage"].get<std::string>();
}

// ─── Group ─────────────────────────────────────────────────────────────────

struct Group {
    int id;
    std::string name;
    std::optional<std::string> description;
    std::optional<std::string> color;
    std::optional<int> display_order;
    std::optional<std::string> created_at;
    std::optional<std::string> updated_at;
    std::unordered_map<std::string, json> extra;
};

inline void from_json(const json& j, Group& g) {
    j.at("id").get_to(g.id);
    j.at("name").get_to(g.name);
    if (j.contains("description")) g.description = j["description"].get<std::string>();
    if (j.contains("color")) g.color = j["color"].get<std::string>();
    if (j.contains("displayOrder")) g.display_order = j["displayOrder"].get<int>();
    if (j.contains("createdAt")) g.created_at = j["createdAt"].get<std::string>();
    if (j.contains("updatedAt")) g.updated_at = j["updatedAt"].get<std::string>();

    static const std::vector<std::string> known = {
        "id", "name", "description", "color", "displayOrder", "createdAt", "updatedAt"
    };
    for (auto& [key, val] : j.items()) {
        if (std::find(known.begin(), known.end(), key) == known.end()) {
            g.extra[key] = val;
        }
    }
}

inline void to_json(json& j, const Group& g) {
    j = json{{"id", g.id}, {"name", g.name}};
    if (g.description) j["description"] = *g.description;
    if (g.color) j["color"] = *g.color;
    if (g.display_order) j["displayOrder"] = *g.display_order;
    if (g.created_at) j["createdAt"] = *g.created_at;
    if (g.updated_at) j["updatedAt"] = *g.updated_at;
    for (auto& [key, val] : g.extra) {
        j[key] = val;
    }
}

// ─── CreateGroupRequest ────────────────────────────────────────────────────

struct CreateGroupRequest {
    std::string name;
    std::optional<std::string> description;
    std::optional<std::string> color;
};

inline void to_json(json& j, const CreateGroupRequest& r) {
    j = json{{"name", r.name}};
    if (r.description) j["description"] = *r.description;
    if (r.color) j["color"] = *r.color;
}

// ─── Extension ─────────────────────────────────────────────────────────────

struct Extension {
    int id;
    std::string name;
    std::optional<std::string> path;
    std::optional<std::string> description;
    std::optional<std::string> icon;
    std::optional<std::string> icon_data_url;
    std::optional<std::string> created_at;
    std::unordered_map<std::string, json> extra;
};

inline void from_json(const json& j, Extension& e) {
    j.at("id").get_to(e.id);
    j.at("name").get_to(e.name);
    if (j.contains("path")) e.path = j["path"].get<std::string>();
    if (j.contains("description")) e.description = j["description"].get<std::string>();
    if (j.contains("icon")) e.icon = j["icon"].get<std::string>();
    if (j.contains("iconDataUrl")) e.icon_data_url = j["iconDataUrl"].get<std::string>();
    if (j.contains("createdAt")) e.created_at = j["createdAt"].get<std::string>();

    static const std::vector<std::string> known = {
        "id", "name", "path", "description", "icon", "iconDataUrl", "createdAt"
    };
    for (auto& [key, val] : j.items()) {
        if (std::find(known.begin(), known.end(), key) == known.end()) {
            e.extra[key] = val;
        }
    }
}

inline void to_json(json& j, const Extension& e) {
    j = json{{"id", e.id}, {"name", e.name}};
    if (e.path) j["path"] = *e.path;
    if (e.description) j["description"] = *e.description;
    if (e.icon) j["icon"] = *e.icon;
    if (e.icon_data_url) j["iconDataUrl"] = *e.icon_data_url;
    if (e.created_at) j["createdAt"] = *e.created_at;
    for (auto& [key, val] : e.extra) {
        j[key] = val;
    }
}

// ─── Automation ────────────────────────────────────────────────────────────

struct Automation {
    int id;
    std::string name;
    std::optional<std::string> description;
    std::optional<std::string> status;
    std::optional<std::string> last_run;
    std::optional<std::string> created_at;
    std::optional<std::string> updated_at;
    std::unordered_map<std::string, json> extra;
};

inline void from_json(const json& j, Automation& a) {
    j.at("id").get_to(a.id);
    j.at("name").get_to(a.name);
    if (j.contains("description")) a.description = j["description"].get<std::string>();
    if (j.contains("status")) a.status = j["status"].get<std::string>();
    if (j.contains("lastRun")) a.last_run = j["lastRun"].get<std::string>();
    if (j.contains("createdAt")) a.created_at = j["createdAt"].get<std::string>();
    if (j.contains("updatedAt")) a.updated_at = j["updatedAt"].get<std::string>();

    static const std::vector<std::string> known = {
        "id", "name", "description", "status", "lastRun", "createdAt", "updatedAt"
    };
    for (auto& [key, val] : j.items()) {
        if (std::find(known.begin(), known.end(), key) == known.end()) {
            a.extra[key] = val;
        }
    }
}

inline void to_json(json& j, const Automation& a) {
    j = json{{"id", a.id}, {"name", a.name}};
    if (a.description) j["description"] = *a.description;
    if (a.status) j["status"] = *a.status;
    if (a.last_run) j["lastRun"] = *a.last_run;
    if (a.created_at) j["createdAt"] = *a.created_at;
    if (a.updated_at) j["updatedAt"] = *a.updated_at;
    for (auto& [key, val] : a.extra) {
        j[key] = val;
    }
}

// ─── RunAutomationRequest ──────────────────────────────────────────────────

struct RunAutomationRequest {
    int profile_id;
    std::optional<bool> delete_cookies;
    std::optional<std::unordered_map<std::string, std::string>> variables;
};

inline void to_json(json& j, const RunAutomationRequest& r) {
    j = json{{"profileId", r.profile_id}};
    if (r.delete_cookies) j["deleteCookies"] = *r.delete_cookies;
    if (r.variables) j["variables"] = *r.variables;
}

// ─── RunAutomationResult ───────────────────────────────────────────────────

struct RunAutomationResult {
    bool success;
    std::string message;
    std::optional<std::unordered_map<std::string, json>> variables;
};

inline void from_json(const json& j, RunAutomationResult& r) {
    if (j.contains("success")) r.success = j["success"].get<bool>();
    else r.success = false;
    if (j.contains("message")) r.message = j["message"].get<std::string>();
    else r.message = "";
    if (j.contains("variables")) r.variables = j["variables"].get<std::unordered_map<std::string, json>>();
}

// ─── Settings ──────────────────────────────────────────────────────────────

struct Settings {
    std::optional<int> id;
    std::optional<std::string> chrome_path;
    std::optional<std::string> api_key;
    std::optional<std::string> language;
    std::unordered_map<std::string, json> extra;
};

inline void from_json(const json& j, Settings& s) {
    if (j.contains("id")) s.id = j["id"].get<int>();
    if (j.contains("chromePath")) s.chrome_path = j["chromePath"].get<std::string>();
    if (j.contains("apiKey")) s.api_key = j["apiKey"].get<std::string>();
    if (j.contains("language")) s.language = j["language"].get<std::string>();

    static const std::vector<std::string> known = {
        "id", "chromePath", "apiKey", "language"
    };
    for (auto& [key, val] : j.items()) {
        if (std::find(known.begin(), known.end(), key) == known.end()) {
            s.extra[key] = val;
        }
    }
}

// ─── SyncStatus ────────────────────────────────────────────────────────────

struct SyncStatus {
    int total;
    int completed;
    bool is_syncing;
    std::vector<json> active;
    std::vector<json> active_extensions;
    std::unordered_map<std::string, json> errors;
    std::unordered_map<std::string, json> progress;
};

inline void from_json(const json& j, SyncStatus& s) {
    s.total = j.value("total", 0);
    s.completed = j.value("completed", 0);
    s.is_syncing = j.value("isSyncing", false);
    s.active = j.value("active", std::vector<json>{});
    s.active_extensions = j.value("activeExtensions", std::vector<json>{});
    s.errors = j.value("errors", std::unordered_map<std::string, json>{});
    s.progress = j.value("progress", std::unordered_map<std::string, json>{});
}

// ─── StatusResponse ────────────────────────────────────────────────────────

struct StatusResponse {
    bool success;
    std::string status;
    std::string version;
};

inline void from_json(const json& j, StatusResponse& s) {
    if (j.contains("success")) s.success = j["success"].get<bool>();
    else s.success = false;
    if (j.contains("status")) s.status = j["status"].get<std::string>();
    if (j.contains("version")) s.version = j["version"].get<std::string>();
}

// ─── StartProfileData ──────────────────────────────────────────────────────

struct StartProfileData {
    std::optional<int> debug_port;
    std::unordered_map<std::string, json> extra;
};

// ─── StartProfileResponse ──────────────────────────────────────────────────

struct StartProfileResponse {
    bool success;
    StartProfileData data;
};

// ─── ApiResponse ───────────────────────────────────────────────────────────

using ApiResponse = json;

// ─── DuplicateProfileRequest ───────────────────────────────────────────────

struct DuplicateProfileRequest {
    std::optional<std::string> name;
    std::optional<std::string> directory_name;
};

inline void to_json(json& j, const DuplicateProfileRequest& r) {
    j = json::object();
    if (r.name) j["name"] = *r.name;
    if (r.directory_name) j["directoryName"] = *r.directory_name;
}

} // namespace antybrowser
