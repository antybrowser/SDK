require "net/http"
require "json"
require "uri"

module AntyBrowser
  class Client
    attr_reader :base_url, :api_key

    def initialize(api_key, port: 5173, base_url: nil, timeout: 30)
      @api_key = api_key
      @base_url = base_url || "http://127.0.0.1:#{port}"
      @timeout = timeout
    end

    # ─── System ──────────────────────────────────────────────────────────

    def get_status
      get("/api/status")
    end

    def get_settings
      get("/api/settings")
    end

    def get_sync_status
      SyncStatus.new(get("/api/sync/status"))
    end

    def refresh_sync(profile_id: nil)
      body = profile_id ? { "profileId" => profile_id } : {}
      post("/api/sync/refresh", body)
    end

    # ─── Profiles ────────────────────────────────────────────────────────

    def get_profiles
      get("/api/profiles").map { |d| Profile.new(d) }
    end

    def create_profile(data)
      Profile.new(post("/api/profiles", data))
    end

    def update_profile(id, data)
      Profile.new(put("/api/profiles/#{id}", data))
    end

    def delete_profile(id)
      delete("/api/profiles/#{id}")
    end

    def start_profile(id)
      result = post("/api/profiles/#{id}/start", {})
      { "success" => result["success"], "data" => result["data"] }
    end

    def stop_profile(id)
      post("/api/profiles/#{id}/stop", {})
    end

    def duplicate_profile(id, name: nil, directory_name: nil)
      body = {}
      body["name"] = name if name
      body["directoryName"] = directory_name if directory_name
      Profile.new(post("/api/profiles/#{id}/duplicate", body))
    end

    # ─── Automations ─────────────────────────────────────────────────────

    def get_automations
      get("/api/automations").map { |d| Automation.new(d) }
    end

    def run_automation(id, profile_id:, delete_cookies: nil, variables: nil)
      body = { "profileId" => profile_id }
      body["deleteCookies"] = delete_cookies unless delete_cookies.nil?
      body["variables"] = variables if variables
      result = post("/api/automations/#{id}/run", body)
      {
        "success" => result["success"],
        "message" => result["message"],
        "variables" => result["variables"],
      }
    end

    # ─── Groups ──────────────────────────────────────────────────────────

    def get_groups
      get("/api/groups").map { |d| Group.new(d) }
    end

    def create_group(data)
      Group.new(post("/api/groups", data))
    end

    def update_group(id, data)
      Group.new(put("/api/groups/#{id}", data))
    end

    def delete_group(id)
      delete("/api/groups/#{id}")
    end

    # ─── Proxies ─────────────────────────────────────────────────────────

    def get_proxies
      get("/api/proxies").map { |d| Proxy.new(d) }
    end

    def create_proxy(data)
      Proxy.new(post("/api/proxies", data))
    end

    def check_proxy(host:, port:, username: nil, password: nil, type: nil)
      body = { "host" => host, "port" => port }
      body["username"] = username if username
      body["password"] = password if password
      body["type"] = type if type
      ProxyCheckResult.new(post("/api/proxies/check", body))
    end

    def check_proxies_bulk(proxies)
      result = post("/api/proxies/check-bulk", { "proxies" => proxies })
      results = result["results"] || result
      results.map { |r| ProxyCheckResult.new(r) }
    end

    def delete_proxy(id)
      delete("/api/proxies/#{id}")
    end

    # ─── Extensions ──────────────────────────────────────────────────────

    def get_extensions
      get("/api/extensions").map { |d| Extension.new(d) }
    end

    def delete_extension(id)
      delete("/api/extensions/#{id}")
    end

    def get_profile_extensions(profile_id, details: false)
      get("/api/profiles/#{profile_id}/extensions?details=#{details}").map { |d| Extension.new(d) }
    end

    def set_profile_extensions(profile_id, extension_ids)
      post("/api/profiles/#{profile_id}/extensions", { "extensionIds" => extension_ids })
    end

    private

    def get(path)
      request(Net::HTTP::Get, path)
    end

    def post(path, body)
      request(Net::HTTP::Post, path, body)
    end

    def put(path, body)
      request(Net::HTTP::Put, path, body)
    end

    def delete(path)
      request(Net::HTTP::Delete, path)
    end

    def request(method_class, path, body = nil)
      uri = URI.parse("#{@base_url}#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = @timeout
      http.read_timeout = @timeout

      req = method_class.new(uri.request_uri)
      req["x-api-key"] = @api_key
      req["Content-Type"] = "application/json"
      req.body = body.to_json if body

      begin
        response = http.request(req)
      rescue StandardError => e
        raise AntyBrowserError, "Failed to connect to AntyBrowser: #{e.message}"
      end

      parse_response(response)
    end

    def parse_response(response)
      code = response.code.to_i
      body = response.body || ""

      if code < 200 || code >= 300
        raise AntyBrowserError.new(
          "API request failed with status #{code}",
          status_code: code,
          response_body: body
        )
      end

      return {} if body.strip.empty?

      JSON.parse(body)
    rescue JSON::ParserError
      raise AntyBrowserError.new(
        "Invalid JSON response from API",
        status_code: response.code.to_i,
        response_body: body
      )
    end
  end
end
