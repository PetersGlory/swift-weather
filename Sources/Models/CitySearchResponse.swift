import Foundation

struct CitySearchResponse: Codable {
    let results: [CityResult]?
}

struct CityResult: Codable, Identifiable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String
    let countryCode: String
    let admin1: String?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, country
        case countryCode = "country_code"
        case admin1
    }

    var displayName: String {
        if let admin1 = admin1 {
            return "\(name), \(admin1), \(country)"
        }
        return "\(name), \(country)"
    }
}
