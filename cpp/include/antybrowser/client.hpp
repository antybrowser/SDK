#pragma once

#include <algorithm>
#include <curl/curl.h>
#include <memory>
#include <nlohmann/json.hpp>
#include <string>
#include <type_traits>
#include <vector>

#include "antybrowser/error.hpp"
#include "antybrowser/types.hpp"

namespace antybrowser {

using json = nlohmann::json;

namespace detail {

struct CurlDeleter {
    void operator()(CURL* ptr) const { curl_easy_cleanup(ptr); }
};

struct CurlSlistDeleter {
    void operator()(curl_slist* ptr) const { curl_slist_free_all(ptr); }
};

using CurlHandle = std::unique_ptr<CURL, CurlDeleter>;
using CurlHeaders = std::unique_ptr<curl_slist, CurlSlistDeleter>;

struct WriteBuffer {
    std::string data;
};

inline size_t write_callback(char* ptr, size_t size, size_t nmemb, void* userdata) {
    auto* buf = static_cast<WriteBuffer*>(userdata);
    buf->data.append(ptr, size * nmemb);
    return size * nmemb;
}

} // namespace detail

class AntybrowserClient {
public:
    AntybrowserClient(std::string api_key, int port = 5173,
                      std::string base_url = "", int timeout = 30000)
        : api_key_(std::move(api_key)),
          base_url_(base_url.empty() ? "http://127.0.0.1:" + std::to_string(port) : std::move(base_url)),
          timeout_(timeout) {
        curl_global_init(CURL_GLOBAL_DEFAULT);
    }

    ~AntybrowserClient() {
        curl_global_cleanup();
    }

    AntybrowserClient(const AntybrowserClient&) = delete;
    AntybrowserClient& operator=(const AntybrowserClient&) = delete;
    AntybrowserClient(AntybrowserClient&&) = default;
    AntybrowserClient& operator=(AntybrowserClient&&) = default;

    // ─── System ──────────────────────────────────────────────────────────

    StatusResponse get_status() {
        return get_impl<StatusResponse>("/api/status");
    }

    Settings get_settings() {
        return get_impl<Settings>("/api/settings");
    }

    SyncStatus get_sync_status() {
        return get_impl<SyncStatus>("/api/sync/status");
    }

    json refresh_sync(std::optional<int> profile_id = std::nullopt) {
        json body = json::object();
        if (profile_id) body["profileId"] = *profile_id;
        return post_impl("/api/sync/refresh", body);
    }

    // ─── Profiles ────────────────────────────────────────────────────────

    std::vector<Profile> get_profiles() {
        return get_impl<std::vector<Profile>>("/api/profiles");
    }

    Profile create_profile(const CreateProfileRequest& request) {
        return post_impl_typed<Profile>("/api/profiles", json(request));
    }

    Profile update_profile(int profile_id, const json& updates) {
        return put_impl<Profile>("/api/profiles/" + std::to_string(profile_id), updates);
    }

    json delete_profile(int profile_id) {
        return delete_impl("/api/profiles/" + std::to_string(profile_id));
    }

    StartProfileResponse start_profile(int profile_id) {
        json data = post_impl("/api/profiles/" + std::to_string(profile_id) + "/start");
        StartProfileResponse resp;
        resp.success = data.value("success", false);
        if (data.contains("data")) {
            resp.data.debug_port = data["data"].value("debugPort", 0);
            for (auto& [k, v] : data["data"].items()) {
                if (k != "debugPort") resp.data.extra[k] = v;
            }
        }
        return resp;
    }

    json stop_profile(int profile_id) {
        return post_impl("/api/profiles/" + std::to_string(profile_id) + "/stop");
    }

    Profile duplicate_profile(int profile_id,
                              const DuplicateProfileRequest& options = {}) {
        return post_impl_typed<Profile>(
            "/api/profiles/" + std::to_string(profile_id) + "/duplicate",
            json(options));
    }

    // ─── Automations ─────────────────────────────────────────────────────

    std::vector<Automation> get_automations() {
        return get_impl<std::vector<Automation>>("/api/automations");
    }

    RunAutomationResult run_automation(int automation_id,
                                       const RunAutomationRequest& request) {
        return post_impl_typed<RunAutomationResult>(
            "/api/automations/" + std::to_string(automation_id) + "/run",
            json(request));
    }

    // ─── Groups ──────────────────────────────────────────────────────────

    std::vector<Group> get_groups() {
        return get_impl<std::vector<Group>>("/api/groups");
    }

    Group create_group(const CreateGroupRequest& request) {
        return post_impl_typed<Group>("/api/groups", json(request));
    }

    Group update_group(int group_id, const json& updates) {
        return put_impl<Group>("/api/groups/" + std::to_string(group_id), updates);
    }

    json delete_group(int group_id) {
        return delete_impl("/api/groups/" + std::to_string(group_id));
    }

    // ─── Proxies ─────────────────────────────────────────────────────────

    std::vector<Proxy> get_proxies() {
        return get_impl<std::vector<Proxy>>("/api/proxies");
    }

    Proxy create_proxy(const CreateProxyRequest& request) {
        return post_impl_typed<Proxy>("/api/proxies", json(request));
    }

    ProxyCheckResult check_proxy(const std::string& host, int port,
                                 const std::optional<std::string>& username = std::nullopt,
                                 const std::optional<std::string>& password = std::nullopt,
                                 const std::optional<std::string>& type = std::nullopt) {
        json body = {{"host", host}, {"port", port}};
        if (username) body["username"] = *username;
        if (password) body["password"] = *password;
        if (type) body["type"] = *type;
        return post_impl_typed<ProxyCheckResult>("/api/proxies/check", body);
    }

    std::vector<ProxyCheckResult> check_proxies_bulk(const json& proxies) {
        json body = {{"proxies", proxies}};
        return post_impl_typed<std::vector<ProxyCheckResult>>("/api/proxies/check-bulk", body);
    }

    json delete_proxy(int proxy_id) {
        return delete_impl("/api/proxies/" + std::to_string(proxy_id));
    }

    // ─── Extensions ──────────────────────────────────────────────────────

    std::vector<Extension> get_extensions() {
        return get_impl<std::vector<Extension>>("/api/extensions");
    }

    json delete_extension(int extension_id) {
        return delete_impl("/api/extensions/" + std::to_string(extension_id));
    }

    std::vector<Extension> get_profile_extensions(int profile_id, bool details = false) {
        std::string path = "/api/profiles/" + std::to_string(profile_id) +
                           "/extensions?details=" + (details ? "true" : "false");
        return get_impl<std::vector<Extension>>(path);
    }

    json set_profile_extensions(int profile_id, const std::vector<int>& extension_ids) {
        json body = {{"extensionIds", extension_ids}};
        return post_impl("/api/profiles/" + std::to_string(profile_id) + "/extensions", body);
    }

private:
    std::string api_key_;
    std::string base_url_;
    int timeout_;

    static std::string escape_url(const std::string& url) {
        CURL* raw = curl_easy_init();
        char* escaped = curl_easy_escape(raw, url.c_str(), static_cast<int>(url.length()));
        std::string result(escaped);
        curl_free(escaped);
        curl_easy_cleanup(raw);
        return result;
    }

    json do_request(const std::string& method, const std::string& path,
                    const json& body = json()) {
        detail::CurlHandle handle(curl_easy_init());
        if (!handle) {
            throw AntybrowserError("Failed to initialize libcurl");
        }

        std::string url = base_url_ + path;
        detail::WriteBuffer buffer;
        detail::CurlHeaders headers(nullptr);

        std::string api_key_header = "x-api-key: " + api_key_;
        headers.reset(curl_slist_append(headers.get(), api_key_header.c_str()));
        headers.reset(curl_slist_append(headers.get(), "Content-Type: application/json"));

        curl_easy_setopt(handle.get(), CURLOPT_URL, url.c_str());
        curl_easy_setopt(handle.get(), CURLOPT_HTTPHEADER, headers.get());
        curl_easy_setopt(handle.get(), CURLOPT_WRITEFUNCTION, detail::write_callback);
        curl_easy_setopt(handle.get(), CURLOPT_WRITEDATA, &buffer);
        curl_easy_setopt(handle.get(), CURLOPT_TIMEOUT_MS, static_cast<long>(timeout_));

        if (method == "POST") {
            curl_easy_setopt(handle.get(), CURLOPT_POST, 1L);
            if (!body.is_null()) {
                std::string body_str = body.dump();
                curl_easy_setopt(handle.get(), CURLOPT_POSTFIELDS, body_str.c_str());
                curl_easy_setopt(handle.get(), CURLOPT_POSTFIELDSIZE,
                                 static_cast<long>(body_str.size()));
            }
        } else if (method == "PUT") {
            curl_easy_setopt(handle.get(), CURLOPT_CUSTOMREQUEST, "PUT");
            if (!body.is_null()) {
                std::string body_str = body.dump();
                curl_easy_setopt(handle.get(), CURLOPT_POSTFIELDS, body_str.c_str());
                curl_easy_setopt(handle.get(), CURLOPT_POSTFIELDSIZE,
                                 static_cast<long>(body_str.size()));
            }
        } else if (method == "DELETE") {
            curl_easy_setopt(handle.get(), CURLOPT_CUSTOMREQUEST, "DELETE");
        }

        CURLcode res = curl_easy_perform(handle.get());
        if (res != CURLE_OK) {
            throw AntybrowserError(
                std::string("Failed to connect to Antybrowser: ") +
                curl_easy_strerror(res));
        }

        long http_code = 0;
        curl_easy_getinfo(handle.get(), CURLINFO_RESPONSE_CODE, &http_code);

        if (http_code < 200 || http_code >= 300) {
            throw AntybrowserError(
                "API request failed with status " + std::to_string(http_code),
                static_cast<int>(http_code), buffer.data);
        }

        if (buffer.data.empty()) return json::object();

        try {
            return json::parse(buffer.data);
        } catch (const json::parse_error&) {
            throw AntybrowserError(
                "Invalid JSON response from API",
                static_cast<int>(http_code), buffer.data);
        }
    }

    template <typename T>
    T parse_response(const json& j) {
        if constexpr (std::is_same_v<T, json>) {
            return j;
        } else {
            return j.get<T>();
        }
    }

    template <typename T>
    T get_impl(const std::string& path) {
        return parse_response<T>(do_request("GET", path));
    }

    template <typename T>
    T post_impl_typed(const std::string& path, const json& body) {
        return parse_response<T>(do_request("POST", path, body));
    }

    json post_impl(const std::string& path, const json& body = json()) {
        return do_request("POST", path, body);
    }

    template <typename T>
    T put_impl(const std::string& path, const json& body) {
        return parse_response<T>(do_request("PUT", path, body));
    }

    json delete_impl(const std::string& path) {
        return do_request("DELETE", path);
    }
};

} // namespace antybrowser
