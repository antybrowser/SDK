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
    public let name: String?
    public let status: String?
    public let browserType: String?
    public let osFingerprint: String?
    public let language: String?
    public let directoryName: String?
    public let createdAt: String?
    public let updatedAt: String?
}

public struct CreateProfileRequest: Codable {
    public let name: String
    public let browserType: String?
    public let osFingerprint: String?
    public let language: String?
    public let useFingerprint: Bool?
    public let groupId: Int?
    public let proxyId: Int?
    
    public init(name: String, browserType: String? = nil, osFingerprint: String? = nil, language: String? = nil, useFingerprint: Bool? = nil, groupId: Int? = nil, proxyId: Int? = nil) {
        self.name = name
        self.browserType = browserType
        self.osFingerprint = osFingerprint
        self.language = language
        self.useFingerprint = useFingerprint
        self.groupId = groupId
        self.proxyId = proxyId
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

public struct ProxyCheckResult: Codable {
    public let success: Bool
    public let ip: String?
    public let country: String?
    public let error: String?
}

public struct Extension: Codable {
    public let id: Int
    public let name: String
    public let description: String?
    public let version: String?
}

public struct Settings: Codable {
    public let apiKey: String?
    public let language: String?
}

public struct SyncStatus: Codable {
    public let isSyncing: Bool
    public let total: Int
    public let completed: Int
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
