import Foundation

enum APIEndpoint {
    case weather(latitude: Double, longitude: Double)
    case searchCity(query: String)

    var baseURL: String {
        switch self {
        case .weather:
            return "https://api.open-meteo.com"
        case .searchCity:
            return "https://geocoding-api.open-meteo.com"
        }
    }

    var path: String {
        switch self {
        case .weather:
            return "/v1/forecast"
        case .searchCity:
            return "/v1/search"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .weather(let lat, let lon):
            return [
                URLQueryItem(name: "latitude", value: "\(lat)"),
                URLQueryItem(name: "longitude", value: "\(lon)"),
                URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m,surface_pressure,visibility"),
                URLQueryItem(name: "hourly", value: "temperature_2m,weather_code,precipitation_probability"),
                URLQueryItem(name: "daily", value: "temperature_2m_max,temperature_2m_min,weather_code,sunrise,sunset,uv_index_max"),
                URLQueryItem(name: "timezone", value: "auto"),
                URLQueryItem(name: "forecast_days", value: "7")
            ]
        case .searchCity(let query):
            return [
                URLQueryItem(name: "name", value: query),
                URLQueryItem(name: "count", value: "10"),
                URLQueryItem(name: "language", value: "en"),
                URLQueryItem(name: "format", value: "json")
            ]
        }
    }

    var url: URL? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
}
