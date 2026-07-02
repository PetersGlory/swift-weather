import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    case noInternet
    case emptyResults

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP error \(code)"
        case .decodingError(let error):
            return "Failed to process data: \(error.localizedDescription)"
        case .noInternet:
            return "No internet connection"
        case .emptyResults:
            return "No results found"
        }
    }
}
