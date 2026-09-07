import Foundation

public class AntybrowserClient {
    private let apiKey: String
    private let baseUrl: String
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    public init(apiKey: String, port: Int = 5173) {
        self.apiKey = apiKey
        self.baseUrl = "http://127.0.0.1:\(port)"
        self.session = URLSession.shared
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    // System
    public func getStatus() async throws -> ApiResponse { try await get("/api/status") }
    public func getSettings() async throws -> Settings { try await get("/api/settings") }
    public func getSyncStatus() async throws -> SyncStatus { try await get("/api/sync/status") }
    
    public func refreshSync(profileId: String? = nil) async throws -> ApiResponse {
        let body: [String: Any] = profileId != nil ? ["profileId": profileId!] : [:]
        return try await post("/api/sync/refresh", body: body)
    }
    
    // Profiles
    public func getProfiles() async throws -> [Profile] { try await get("/api/profiles") }
    
    public func createProfile(_ request: CreateProfileRequest) async throws -> Profile {
        try await post("/api/profiles", body: request)
    }
    
    public func updateProfile(id: Int, data: [String: Any]) async throws -> Profile {
        try await put("/api/profiles/\(id)", body: data)
    }
    
    public func deleteProfile(id: Int) async throws -> ApiResponse {
        try await delete("/api/profiles/\(id)")
    }
    
    public func startProfile(id: Int) async throws -> StartProfileResponse {
        try await post("/api/profiles/\(id)/start", body: [:])
    }
    
    public func stopProfile(id: Int) async throws -> ApiResponse {
        try await post("/api/profiles/\(id)/stop", body: [:])
    }
    
    public func duplicateProfile(id: Int, name: String? = nil) async throws -> Profile {
        let body: [String: Any] = name != nil ? ["name": name!] : [:]
        return try await post("/api/profiles/\(id)/duplicate", body: body)
    }
    
    // Automations
    public func getAutomations() async throws -> [Automation] { try await get("/api/automations") }
    
    public func runAutomation(id: Int, profileId: Int) async throws -> RunAutomationResult {
        try await post("/api/automations/\(id)/run", body: ["profileId": profileId])
    }
    
    // Groups
    public func getGroups() async throws -> [Group] { try await get("/api/groups") }
    public func createGroup(_ request: CreateGroupRequest) async throws -> Group { try await post("/api/groups", body: request) }
    public func updateGroup(id: Int, data: [String: Any]) async throws -> Group { try await put("/api/groups/\(id)", body: data) }
    public func deleteGroup(id: Int) async throws -> ApiResponse { try await delete("/api/groups/\(id)") }
    
    // Proxies
    public func getProxies() async throws -> [Proxy] { try await get("/api/proxies") }
    public func createProxy(_ request: CreateProxyRequest) async throws -> Proxy { try await post("/api/proxies", body: request) }
    public func checkProxy(data: [String: Any]) async throws -> ProxyCheckResult { try await post("/api/proxies/check", body: data) }
    public func deleteProxy(id: Int) async throws -> ApiResponse { try await delete("/api/proxies/\(id)") }
    
    // Extensions
    public func getExtensions() async throws -> [Extension] { try await get("/api/extensions") }
    public func deleteExtension(id: Int) async throws -> ApiResponse { try await delete("/api/extensions/\(id)") }
    public func getProfileExtensions(profileId: Int) async throws -> [Extension] { try await get("/api/profiles/\(profileId)/extensions") }
    public func setProfileExtensions(profileId: Int, extensionIds: [Int]) async throws -> ApiResponse {
        try await post("/api/profiles/\(profileId)/extensions", body: ["extensionIds": extensionIds])
    }
    
    // HTTP helpers
    private func get<T: Decodable>(_ path: String) async throws -> T {
        let request = try makeRequest(path: path)
        let (data, response) = try await session.data(for: request)
        return try handleResponse(data: data, response: response)
    }
    
    private func post<T: Decodable>(_ path: String, body: Any) async throws -> T {
        var request = try makeRequest(path: path)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, response) = try await session.data(for: request)
        return try handleResponse(data: data, response: response)
    }
    
    private func put<T: Decodable>(_ path: String, body: Any) async throws -> T {
        var request = try makeRequest(path: path)
        request.httpMethod = "PUT"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, response) = try await session.data(for: request)
        return try handleResponse(data: data, response: response)
    }
    
    private func delete<T: Decodable>(_ path: String) async throws -> T {
        var request = try makeRequest(path: path)
        request.httpMethod = "DELETE"
        let (data, response) = try await session.data(for: request)
        return try handleResponse(data: data, response: response)
    }
    
    private func makeRequest(path: String) throws -> URLRequest {
        guard let url = URL(string: "\(baseUrl)\(path)") else { throw AntybrowserError.invalidURL }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else { throw AntybrowserError.invalidResponse }
        guard (200...299).contains(httpResponse.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw AntybrowserError.apiError(statusCode: httpResponse.statusCode, body: body)
        }
        return try decoder.decode(T.self, from: data)
    }
}
