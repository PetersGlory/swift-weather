import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse
    func searchCity(query: String) async throws -> [CityResult]
}
