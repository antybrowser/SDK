module Antybrowser
  class Profile
    attr_reader :id, :name, :user_id, :user_guid, :directory_name, :group_id,
                :proxy_id, :browser_type, :browser_version, :os_fingerprint,
                :screen_resolution, :screen_maximizable, :language,
                :accept_language, :timezone, :use_fingerprint, :fingerprint_id,
                :platform_version, :brand_version, :engine_version, :gpu_vendor,
                :gpu_model, :hardware_concurrency, :device_memory,
                :device_scale_factor, :mobile_model, :mobile_version,
                :ch_platform, :ch_platform_version, :ch_arch, :ch_bitness,
                :ch_model, :ch_mobile, :disable_spoofing, :location_mode,
                :location_latitude, :location_longitude, :location_accuracy,
                :user_agent, :restore_session, :low_bandwidth, :notes, :start_url,
                :custom_flags, :status, :status_machine_id, :status_heartbeat_at,
                :needs_sync, :last_pid, :debug_port, :tabs_snapshot, :hidden,
                :trash, :deleted_at, :created_at, :updated_at, :last_synced_at,
                :s3_key, :extra

    def initialize(data)
      @id = data["id"]
      @name = data["name"]
      @user_id = data["userId"]
      @user_guid = data["userGuid"]
      @directory_name = data["directoryName"]
      @group_id = data["groupId"]
      @proxy_id = data["proxyId"]
      @browser_type = data["browserType"]
      @browser_version = data["browserVersion"]
      @os_fingerprint = data["osFingerprint"]
      @screen_resolution = data["screenResolution"]
      @screen_maximizable = data["screenMaximizable"]
      @language = data["language"]
      @accept_language = data["acceptLanguage"]
      @timezone = data["timezone"]
      @use_fingerprint = data["useFingerprint"]
      # Server-owned noise seed. Read-only — never sent on create/update.
      @fingerprint_id = data["fingerprintId"]
      # --- Fingerprint surface ---
      @platform_version = data["platformVersion"]
      @brand_version = data["brandVersion"]
      @engine_version = data["engineVersion"]
      @gpu_vendor = data["gpuVendor"]
      @gpu_model = data["gpuModel"]
      @hardware_concurrency = data["hardwareConcurrency"]
      @device_memory = data["deviceMemory"]
      @device_scale_factor = data["deviceScaleFactor"]
      @mobile_model = data["mobileModel"]
      @mobile_version = data["mobileVersion"]
      @ch_platform = data["chPlatform"]
      @ch_platform_version = data["chPlatformVersion"]
      @ch_arch = data["chArch"]
      @ch_bitness = data["chBitness"]
      @ch_model = data["chModel"]
      @ch_mobile = data["chMobile"]
      @disable_spoofing = data["disableSpoofing"]
      # --- Geolocation spoof ---
      @location_mode = data["locationMode"]
      @location_latitude = data["locationLatitude"]
      @location_longitude = data["locationLongitude"]
      @location_accuracy = data["locationAccuracy"]
      @user_agent = data["userAgent"]
      @restore_session = data["restoreSession"]
      @low_bandwidth = data["lowBandwidth"]
      @notes = data["notes"]
      @start_url = data["startUrl"]
      @custom_flags = data["customFlags"]
      @status = data["status"]
      @status_machine_id = data["statusMachineId"]
      @status_heartbeat_at = data["statusHeartbeatAt"]
      @needs_sync = data["needsSync"]
      @last_pid = data["lastPid"]
      @debug_port = data["debugPort"]
      @tabs_snapshot = data["tabsSnapshot"]
      @hidden = data["hidden"]
      @trash = data["trash"]
      @deleted_at = data["deletedAt"]
      @created_at = data["createdAt"]
      @updated_at = data["updatedAt"]
      @last_synced_at = data["lastSyncedAt"]
      @s3_key = data["s3Key"]
      @extra = data.reject { |k, _v| known_keys.include?(k) }
    end

    private

    def known_keys
      %w[id name userId userGuid directoryName groupId proxyId browserType
         browserVersion osFingerprint screenResolution screenMaximizable
         language acceptLanguage timezone useFingerprint fingerprintId
         platformVersion brandVersion engineVersion gpuVendor gpuModel
         hardwareConcurrency deviceMemory deviceScaleFactor mobileModel
         mobileVersion chPlatform chPlatformVersion chArch chBitness chModel
         chMobile disableSpoofing locationMode locationLatitude locationLongitude
         locationAccuracy userAgent restoreSession lowBandwidth notes startUrl
         customFlags status statusMachineId statusHeartbeatAt needsSync lastPid
         debugPort tabsSnapshot hidden trash deletedAt createdAt updatedAt
         lastSyncedAt s3Key]
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
end
