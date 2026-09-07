import Foundation

public enum AntybrowserError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case apiError(statusCode: Int, body: String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response"
        case .apiError(let code, let body): return "API error \(code): \(body)"
        }
    }
}
