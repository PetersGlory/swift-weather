import Foundation

final class CacheManager {
    static let shared = CacheManager()
    private let defaults = UserDefaults.standard

    private enum Keys {
        static let lastCityName = "last_city_name"
        static let lastLatitude = "last_latitude"
        static let lastLongitude = "last_longitude"
        static let cachedWeather = "cached_weather"
    }

    private init() {}

    var lastCityName: String? {
        get { defaults.string(forKey: Keys.lastCityName) }
        set { defaults.set(newValue, forKey: Keys.lastCityName) }
    }

    var lastCoordinates: (latitude: Double, longitude: Double)? {
        get {
            guard let lat = defaults.object(forKey: Keys.lastLatitude) as? Double,
                  let lon = defaults.object(forKey: Keys.lastLongitude) as? Double else {
                return nil
            }
            return (lat, lon)
        }
        set {
            defaults.set(newValue?.latitude, forKey: Keys.lastLatitude)
            defaults.set(newValue?.longitude, forKey: Keys.lastLongitude)
        }
    }

    func saveWeatherResponse(_ response: WeatherResponse) {
        if let data = try? JSONEncoder().encode(response) {
            defaults.set(data, forKey: Keys.cachedWeather)
        }
    }

    func loadCachedWeather() -> WeatherResponse? {
        guard let data = defaults.data(forKey: Keys.cachedWeather) else { return nil }
        return try? JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
