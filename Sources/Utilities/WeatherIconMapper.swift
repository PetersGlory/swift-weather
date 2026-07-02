import Foundation

enum WeatherIconMapper {
    static func iconName(for wmoCode: Int, isNight: Bool = false) -> String {
        let prefix = isNight ? "moon." : "sun."
        switch wmoCode {
        case 0:
            return "\(prefix)max.fill"
        case 1:
            return "\(prefix)cloud.fill"
        case 2:
            return "cloud.fill"
        case 3:
            return "cloud.fill"
        case 45, 48:
            return "cloud.fog.fill"
        case 51, 53, 55:
            return "cloud.drizzle.fill"
        case 56, 57:
            return "cloud.sleet.fill"
        case 61, 63, 65:
            return "cloud.rain.fill"
        case 66, 67:
            return "cloud.snow.fill"
        case 71, 73, 75:
            return "snowflake"
        case 77:
            return "cloud.snow.fill"
        case 80, 81, 82:
            return "cloud.heavyrain.fill"
        case 85, 86:
            return "cloud.snow.fill"
        case 95:
            return "cloud.bolt.fill"
        case 96, 99:
            return "cloud.bolt.rain.fill"
        default:
            return "questionmark"
        }
    }

    static func description(for wmoCode: Int) -> String {
        switch wmoCode {
        case 0:
            return "Clear Sky"
        case 1:
            return "Mainly Clear"
        case 2:
            return "Partly Cloudy"
        case 3:
            return "Overcast"
        case 45:
            return "Foggy"
        case 48:
            return "Depositing Rime Fog"
        case 51:
            return "Light Drizzle"
        case 53:
            return "Moderate Drizzle"
        case 55:
            return "Dense Drizzle"
        case 56:
            return "Light Freezing Drizzle"
        case 57:
            return "Dense Freezing Drizzle"
        case 61:
            return "Slight Rain"
        case 63:
            return "Moderate Rain"
        case 65:
            return "Heavy Rain"
        case 66:
            return "Light Freezing Rain"
        case 67:
            return "Heavy Freezing Rain"
        case 71:
            return "Slight Snow"
        case 73:
            return "Moderate Snow"
        case 75:
            return "Heavy Snow"
        case 77:
            return "Snow Grains"
        case 80:
            return "Slight Rain Showers"
        case 81:
            return "Moderate Rain Showers"
        case 82:
            return "Violent Rain Showers"
        case 85:
            return "Slight Snow Showers"
        case 86:
            return "Heavy Snow Showers"
        case 95:
            return "Thunderstorm"
        case 96:
            return "Thunderstorm with Slight Hail"
        case 99:
            return "Thunderstorm with Heavy Hail"
        default:
            return "Unknown"
        }
    }
}
