import Foundation

enum APIError: Error {
    case failedRequest
    case failedDecoding
    case incorrectBaseUrl
    case unableToCreateUrl
    case invalidResponse
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedRequest:
            return "Failed Request"
        case .failedDecoding:
            return "Failed to Decode Content"
        case .incorrectBaseUrl:
            return "URL Not Found"
        case .unableToCreateUrl:
            return "Error Building URL"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}
