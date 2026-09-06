module AntyBrowser
  class Profile
    attr_reader :id, :name, :directory_name, :group_id, :proxy_id,
                :browser_type, :browser_version, :os_fingerprint,
                :screen_resolution, :language, :accept_language, :timezone,
                :use_fingerprint, :fingerprint_id, :restore_session,
                :low_bandwidth, :notes, :status, :debug_port,
                :created_at, :updated_at, :extra

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @directory_name = data["directoryName"]
      @group_id = data["groupId"]
      @proxy_id = data["proxyId"]
      @browser_type = data["browserType"]
      @browser_version = data["browserVersion"]
      @os_fingerprint = data["osFingerprint"]
      @screen_resolution = data["screenResolution"]
      @language = data["language"]
      @accept_language = data["acceptLanguage"]
      @timezone = data["timezone"]
      @use_fingerprint = data["useFingerprint"]
      @fingerprint_id = data["fingerprintId"]
      @restore_session = data["restoreSession"]
      @low_bandwidth = data["lowBandwidth"]
      @notes = data["notes"]
      @status = data["status"]
      @debug_port = data["debugPort"]
      @created_at = data["createdAt"]
      @updated_at = data["updatedAt"]
      @extra = data.reject { |k, _v| known_keys.include?(k) }
    end

    private

    def known_keys
      %w[id name directoryName groupId proxyId browserType browserVersion
         osFingerprint screenResolution language acceptLanguage timezone
         useFingerprint fingerprintId restoreSession lowBandwidth notes
         status debugPort createdAt updatedAt]
    end
  end

  class Proxy
    attr_reader :id, :name, :type, :host, :port, :username, :status,
                :country_code, :ip, :country, :timezone, :asn, :isp, :extra

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @type = data["type"]
      @host = data["host"]
      @port = data["port"]
      @username = data["username"]
      @status = data["status"]
      @country_code = data["countryCode"]
      @ip = data["ip"]
      @country = data["country"]
      @timezone = data["timezone"]
      @asn = data["asn"]
      @isp = data["isp"]
      @extra = data.reject { |k, _v| known_keys.include?(k) }
    end

    private

    def known_keys
      %w[id name type host port username status countryCode ip country timezone asn isp]
    end
  end

  class Group
    attr_reader :id, :name, :description, :color, :display_order, :created_at, :updated_at

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @description = data["description"]
      @color = data["color"]
      @display_order = data["displayOrder"]
      @created_at = data["createdAt"]
      @updated_at = data["updatedAt"]
    end
  end

  class Extension
    attr_reader :id, :name, :path, :description, :icon, :created_at

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @path = data["path"]
      @description = data["description"]
      @icon = data["icon"]
      @created_at = data["createdAt"]
    end
  end

  class Automation
    attr_reader :id, :name, :description, :status, :last_run, :created_at, :updated_at

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @description = data["description"]
      @status = data["status"]
      @last_run = data["lastRun"]
      @created_at = data["createdAt"]
      @updated_at = data["updatedAt"]
    end
  end

  class SyncStatus
    attr_reader :total, :completed, :is_syncing, :active, :errors, :progress

    def initialize(data)
      @total = data["total"] || 0
      @completed = data["completed"] || 0
      @is_syncing = data["isSyncing"] || false
      @active = data["active"] || []
      @errors = data["errors"] || {}
      @progress = data["progress"] || {}
    end
  end

  class ProxyCheckResult
    attr_reader :success, :details, :error_message

    def initialize(data)
      @success = data["success"] || false
      @details = data["details"]
      @error_message = data["errorMessage"]
    end
  end
end
