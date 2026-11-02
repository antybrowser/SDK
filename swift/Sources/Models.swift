import Foundation

public struct ApiResponse: Codable {
    public let success: Bool
    public let message: String?
    public let data: AnyCodable?
}

public struct StartProfileResponse: Codable {
    public let success: Bool
    public let data: StartProfileData
}

public struct StartProfileData: Codable {
    public let debugPort: Int
}

public struct Profile: Codable {
    public let id: Int
    public let userId: Int?
    public let userGuid: String?
    public let name: String?
    public let directoryName: String?
    public let groupId: Int?
    public let proxyId: Int?
    public let browserType: String?
    public let browserVersion: String?
    public let osFingerprint: String?
    public let screenResolution: String?
    public let screenMaximizable: Bool?
    public let language: String?
    public let acceptLanguage: String?
    public let timezone: String?
    public let useFingerprint: Bool?
    /// Server-owned noise seed. Read-only — never sent on create/update.
    public let fingerprintId: String?
    public let platformVersion: String?
    public let brandVersion: String?
    public let engineVersion: String?
    public let gpuVendor: String?
    public let gpuModel: String?
    public let hardwareConcurrency: AnyCodable?
    public let deviceMemory: AnyCodable?
    public let deviceScaleFactor: AnyCodable?
    public let mobileModel: String?
    public let mobileVersion: AnyCodable?
    public let chPlatform: String?
    public let chPlatformVersion: String?
    public let chArch: String?
    public let chBitness: String?
    public let chModel: String?
    public let chMobile: AnyCodable?
    public let disableSpoofing: String?
    public let locationMode: String?
    public let locationLatitude: String?
    public let locationLongitude: String?
    public let locationAccuracy: String?
    public let userAgent: String?
    public let restoreSession: Bool?
    public let lowBandwidth: Bool?
    public let notes: String?
    public let startUrl: String?
    public let customFlags: String?
    public let status: String?
    public let statusMachineId: String?
    public let statusHeartbeatAt: String?
    public let needsSync: Bool?
    public let lastPid: Int?
    public let debugPort: Int?
    public let tabsSnapshot: String?
    public let hidden: Bool?
    public let trash: Bool?
    public let deletedAt: String?
    public let createdAt: String?
    public let updatedAt: String?
    public let lastSyncedAt: String?
    public let s3Key: String?
}

public struct CreateProfileRequest: Codable {
    public let name: String
    public let directoryName: String?
    public let groupId: Int?
    public let proxyId: Int?
    public let browserType: String?
    public let browserVersion: String?
    public let osFingerprint: String?
    public let screenResolution: String?
    public let screenMaximizable: Bool?
    public let language: String?
    public let acceptLanguage: String?
    public let timezone: String?
    public let useFingerprint: Bool?
    public let platformVersion: String?
    public let brandVersion: String?
    public let engineVersion: String?
    public let gpuVendor: String?
    public let gpuModel: String?
    public let hardwareConcurrency: AnyCodable?
    public let deviceMemory: AnyCodable?
    public let deviceScaleFactor: AnyCodable?
    public let mobileModel: String?
    public let mobileVersion: AnyCodable?
    public let chPlatform: String?
    public let chPlatformVersion: String?
    public let chArch: String?
    public let chBitness: String?
    public let chModel: String?
    public let chMobile: AnyCodable?
    public let disableSpoofing: String?
    public let locationMode: String?
    public let locationLatitude: String?
    public let locationLongitude: String?
    public let locationAccuracy: String?
    public let restoreSession: Bool?
    public let lowBandwidth: Bool?
    public let notes: String?
    public let startUrl: String?
    public let customFlags: String?
    public let status: String?
    public let hidden: Bool?

    public init(
        name: String,
        directoryName: String? = nil,
        groupId: Int? = nil,
        proxyId: Int? = nil,
        browserType: String? = nil,
        browserVersion: String? = nil,
        osFingerprint: String? = nil,
        screenResolution: String? = nil,
        screenMaximizable: Bool? = nil,
        language: String? = nil,
        acceptLanguage: String? = nil,
        timezone: String? = nil,
        useFingerprint: Bool? = nil,
        platformVersion: String? = nil,
        brandVersion: String? = nil,
        engineVersion: String? = nil,
        gpuVendor: String? = nil,
        gpuModel: String? = nil,
        hardwareConcurrency: AnyCodable? = nil,
        deviceMemory: AnyCodable? = nil,
        deviceScaleFactor: AnyCodable? = nil,
        mobileModel: String? = nil,
        mobileVersion: AnyCodable? = nil,
        chPlatform: String? = nil,
        chPlatformVersion: String? = nil,
        chArch: String? = nil,
        chBitness: String? = nil,
        chModel: String? = nil,
        chMobile: AnyCodable? = nil,
        disableSpoofing: String? = nil,
        locationMode: String? = nil,
        locationLatitude: String? = nil,
        locationLongitude: String? = nil,
        locationAccuracy: String? = nil,
        restoreSession: Bool? = nil,
        lowBandwidth: Bool? = nil,
        notes: String? = nil,
        startUrl: String? = nil,
        customFlags: String? = nil,
        status: String? = nil,
        hidden: Bool? = nil
    ) {
        self.name = name
        self.directoryName = directoryName
        self.groupId = groupId
        self.proxyId = proxyId
        self.browserType = browserType
        self.browserVersion = browserVersion
        self.osFingerprint = osFingerprint
        self.screenResolution = screenResolution
        self.screenMaximizable = screenMaximizable
        self.language = language
        self.acceptLanguage = acceptLanguage
        self.timezone = timezone
        self.useFingerprint = useFingerprint
        self.platformVersion = platformVersion
        self.brandVersion = brandVersion
        self.engineVersion = engineVersion
        self.gpuVendor = gpuVendor
        self.gpuModel = gpuModel
        self.hardwareConcurrency = hardwareConcurrency
        self.deviceMemory = deviceMemory
        self.deviceScaleFactor = deviceScaleFactor
        self.mobileModel = mobileModel
        self.mobileVersion = mobileVersion
        self.chPlatform = chPlatform
        self.chPlatformVersion = chPlatformVersion
        self.chArch = chArch
        self.chBitness = chBitness
        self.chModel = chModel
        self.chMobile = chMobile
        self.disableSpoofing = disableSpoofing
        self.locationMode = locationMode
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.locationAccuracy = locationAccuracy
        self.restoreSession = restoreSession
        self.lowBandwidth = lowBandwidth
        self.notes = notes
        self.startUrl = startUrl
        self.customFlags = customFlags
        self.status = status
        self.hidden = hidden
    }
}

public struct UpdateProfileRequest: Codable {
    public let name: String?
    public let directoryName: String?
    public let groupId: Int?
    public let proxyId: Int?
    public let browserType: String?
    public let browserVersion: String?
    public let osFingerprint: String?
    public let screenResolution: String?
    public let screenMaximizable: Bool?
    public let language: String?
    public let acceptLanguage: String?
    public let timezone: String?
    public let useFingerprint: Bool?
    public let platformVersion: String?
    public let brandVersion: String?
    public let engineVersion: String?
    public let gpuVendor: String?
    public let gpuModel: String?
    public let hardwareConcurrency: AnyCodable?
    public let deviceMemory: AnyCodable?
    public let deviceScaleFactor: AnyCodable?
    public let mobileModel: String?
    public let mobileVersion: AnyCodable?
    public let chPlatform: String?
    public let chPlatformVersion: String?
    public let chArch: String?
    public let chBitness: String?
    public let chModel: String?
    public let chMobile: AnyCodable?
    public let disableSpoofing: String?
    public let locationMode: String?
    public let locationLatitude: String?
    public let locationLongitude: String?
    public let locationAccuracy: String?
    public let restoreSession: Bool?
    public let lowBandwidth: Bool?
    public let notes: String?
    public let startUrl: String?
    public let customFlags: String?
    public let status: String?
    public let hidden: Bool?

    public init(
        name: String? = nil,
        directoryName: String? = nil,
        groupId: Int? = nil,
        proxyId: Int? = nil,
        browserType: String? = nil,
        browserVersion: String? = nil,
        osFingerprint: String? = nil,
        screenResolution: String? = nil,
        screenMaximizable: Bool? = nil,
        language: String? = nil,
        acceptLanguage: String? = nil,
        timezone: String? = nil,
        useFingerprint: Bool? = nil,
        platformVersion: String? = nil,
        brandVersion: String? = nil,
        engineVersion: String? = nil,
        gpuVendor: String? = nil,
        gpuModel: String? = nil,
        hardwareConcurrency: AnyCodable? = nil,
        deviceMemory: AnyCodable? = nil,
        deviceScaleFactor: AnyCodable? = nil,
        mobileModel: String? = nil,
        mobileVersion: AnyCodable? = nil,
        chPlatform: String? = nil,
        chPlatformVersion: String? = nil,
        chArch: String? = nil,
        chBitness: String? = nil,
        chModel: String? = nil,
        chMobile: AnyCodable? = nil,
        disableSpoofing: String? = nil,
        locationMode: String? = nil,
        locationLatitude: String? = nil,
        locationLongitude: String? = nil,
        locationAccuracy: String? = nil,
        restoreSession: Bool? = nil,
        lowBandwidth: Bool? = nil,
        notes: String? = nil,
        startUrl: String? = nil,
        customFlags: String? = nil,
        status: String? = nil,
        hidden: Bool? = nil
    ) {
        self.name = name
        self.directoryName = directoryName
        self.groupId = groupId
        self.proxyId = proxyId
        self.browserType = browserType
        self.browserVersion = browserVersion
        self.osFingerprint = osFingerprint
        self.screenResolution = screenResolution
        self.screenMaximizable = screenMaximizable
        self.language = language
        self.acceptLanguage = acceptLanguage
        self.timezone = timezone
        self.useFingerprint = useFingerprint
        self.platformVersion = platformVersion
        self.brandVersion = brandVersion
        self.engineVersion = engineVersion
        self.gpuVendor = gpuVendor
        self.gpuModel = gpuModel
        self.hardwareConcurrency = hardwareConcurrency
        self.deviceMemory = deviceMemory
        self.deviceScaleFactor = deviceScaleFactor
        self.mobileModel = mobileModel
        self.mobileVersion = mobileVersion
        self.chPlatform = chPlatform
        self.chPlatformVersion = chPlatformVersion
        self.chArch = chArch
        self.chBitness = chBitness
        self.chModel = chModel
        self.chMobile = chMobile
        self.disableSpoofing = disableSpoofing
        self.locationMode = locationMode
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.locationAccuracy = locationAccuracy
        self.restoreSession = restoreSession
        self.lowBandwidth = lowBandwidth
        self.notes = notes
        self.startUrl = startUrl
        self.customFlags = customFlags
        self.status = status
        self.hidden = hidden
    }
}

public struct Automation: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public let status: String?
}

public struct RunAutomationResult: Codable {
    public let success: Bool
    public let message: String?
}

public struct Group: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public let color: String?
}

public struct CreateGroupRequest: Codable {
    public let name: String
    public let description: String?
    
    public init(name: String, description: String? = nil) {
        self.name = name
        self.description = description
    }
}

public struct Proxy: Codable {
    public let id: Int
    public let name: String?
    public let host: String?
    public let port: Int?
    public let protocol: String?
}

public struct CreateProxyRequest: Codable {
    public let name: String
    public let host: String
    public let port: Int
    public let protocol: String?
    public let username: String?
    public let password: String?
    
    public init(name: String, host: String, port: Int, protocol: String? = nil, username: String? = nil, password: String? = nil) {
        self.name = name
        self.host = host
        self.port = port
        self.`protocol` = `protocol`
        self.username = username
        self.password = password
    }
}

public struct Extension: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public let version: String?
}

// Helper for AnyCodable
public struct AnyCodable: Codable {
    public let value: Any
    
    public init(_ value: Any) { self.value = value }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int = try? container.decode(Int.self) { value = int }
        else if let double = try? container.decode(Double.self) { value = double }
        else if let bool = try? container.decode(Bool.self) { value = bool }
        else if let string = try? container.decode(String.self) { value = string }
        else if let dict = try? container.decode([String: AnyCodable].self) { value = dict }
        else if let arr = try? container.decode([AnyCodable].self) { value = arr }
        else { value = NSNull() }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let int = value as? Int { try container.encode(int) }
        else if let double = value as? Double { try container.encode(double) }
        else if let bool = value as? Bool { try container.encode(bool) }
        else if let string = value as? String { try container.encode(string) }
    }
}
