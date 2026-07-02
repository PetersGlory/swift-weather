import SwiftUI

struct DetailView: View {
    let weather: WeatherResponse

    var body: some View {
        List {
            Section("Current Conditions") {
                DetailRow(label: "Temperature", value: "\(Int(weather.current.temperature2m))°C")
                DetailRow(label: "Feels Like", value: "\(Int(weather.current.apparentTemperature))°C")
                DetailRow(label: "Condition", value: WeatherIconMapper.description(for: weather.current.weatherCode))
                DetailRow(label: "Humidity", value: "\(weather.current.relativeHumidity2m)%")
                DetailRow(label: "Wind Speed", value: "\(String(format: "%.1f", weather.current.windSpeed10m)) km/h")

                if let pressure = weather.current.surfacePressure {
                    DetailRow(label: "Pressure", value: "\(Int(pressure)) hPa")
                }
                if let visibility = weather.current.visibility {
                    DetailRow(label: "Visibility", value: "\(String(format: "%.1f", visibility / 1000)) km")
                }
            }

            if let today = weather.daily.time.first,
               let index = weather.daily.time.firstIndex(of: today) {
                Section("Today's Details") {
                    DetailRow(label: "High", value: "\(Int(weather.daily.temperature2mMax[index]))°C")
                    DetailRow(label: "Low", value: "\(Int(weather.daily.temperature2mMin[index]))°C")

                    if let sunrise = weather.daily.sunrise?[index] {
                        DetailRow(label: "Sunrise", value: formattedTime(sunrise))
                    }
                    if let sunset = weather.daily.sunset?[index] {
                        DetailRow(label: "Sunset", value: formattedTime(sunset))
                    }
                    if let uv = weather.daily.uvIndexMax?[index] {
                        DetailRow(label: "UV Index", value: "\(String(format: "%.1f", uv))")
                    }
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formattedTime(_ iso: String) -> String {
        let parser = DateFormatter()
        parser.dateFormat = "yyyy-MM-dd'T'HH:mm"
        parser.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = parser.date(from: iso) else { return iso }
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        return timeFormatter.string(from: date)
    }
}

private struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}
