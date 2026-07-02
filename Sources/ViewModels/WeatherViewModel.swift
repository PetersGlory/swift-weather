import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: WeatherResponse?
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?
    @Published var cityName: String = ""

    private let weatherService: WeatherServiceProtocol
    private let cacheManager: CacheManager

    init(weatherService: WeatherServiceProtocol = WeatherService.shared,
         cacheManager: CacheManager = .shared) {
        self.weatherService = weatherService
        self.cacheManager = cacheManager
        loadCachedData()
        loadLastCityWeather()
    }

    private func loadCachedData() {
        if let cached = cacheManager.loadCachedWeather() {
            weather = cached
        }
    }

    private func loadLastCityWeather() {
        if let name = cacheManager.lastCityName {
            cityName = name
        }
        if let coords = cacheManager.lastCoordinates {
            Task {
                await fetchWeather(latitude: coords.latitude, longitude: coords.longitude)
            }
        }
    }

    func fetchWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        error = nil

        do {
            let response = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            weather = response
            cacheManager.saveWeatherResponse(response)
            cacheManager.lastCoordinates = (latitude, longitude)
        } catch let networkError as NetworkError {
            error = networkError.errorDescription
        } catch {
            error = error.localizedDescription
        }

        isLoading = false
    }

    func searchAndLoad(cityName name: String, results: [CityResult]) {
        guard let city = results.first(where: { $0.name.lowercased() == name.lowercased() })
                ?? results.first else { return }

        cityName = city.displayName
        cacheManager.lastCityName = city.displayName

        Task {
            await fetchWeather(latitude: city.latitude, longitude: city.longitude)
        }
    }

    func loadWeatherForCity(_ city: CityResult) {
        cityName = city.displayName
        cacheManager.lastCityName = city.displayName

        Task {
            await fetchWeather(latitude: city.latitude, longitude: city.longitude)
        }
    }
}
