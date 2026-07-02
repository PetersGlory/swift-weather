import Foundation

final class WeatherService: WeatherServiceProtocol {
    static let shared = WeatherService()
    private let apiClient = APIClient.shared

    private init() {}

    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        let response: WeatherResponse = try await apiClient.request(.weather(latitude: latitude, longitude: longitude))
        return response
    }

    func searchCity(query: String) async throws -> [CityResult] {
        let trimmed = query.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return [] }

        let response: CitySearchResponse = try await apiClient.request(.searchCity(query: trimmed))
        return response.results ?? []
    }
}
