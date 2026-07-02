import SwiftUI

struct HourlyForecastView: View {
    let hourly: HourlyForecast

    private var displayedHours: ArraySlice<(time: String, temp: Double, code: Int)> {
        let now = Date()
        let hourData = zip(zip(hourly.time, hourly.temperature2m), hourly.weatherCode)
            .map { ($0.0.0, $0.0.1, $0.1) }

        if let startIndex = hourData.firstIndex(where: { time, _, _ in
            parseOpenMeteoDate(time) >= now
        }) {
            return hourData.dropFirst(startIndex).prefix(24)
        }
        return hourData.prefix(24)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Hourly Forecast", systemImage: "clock")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Array(displayedHours.enumerated()), id: \.offset) { index, data in
                        HourCard(time: data.time, temperature: data.temp, weatherCode: data.code)
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
}

private struct HourCard: View {
    let time: String
    let temperature: Double
    let weatherCode: Int

    var body: some View {
        VStack(spacing: 8) {
            Text(formattedTime)
                .font(.caption)
                .foregroundStyle(.secondary)

            Image(systemName: WeatherIconMapper.iconName(for: weatherCode))
                .font(.title3)

            Text("\(Int(temperature))°")
                .font(.headline)
        }
        .frame(width: 60)
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var formattedTime: String {
        let date = parseOpenMeteoDate(time)
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: date).lowercased()
    }
}

private func parseOpenMeteoDate(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    return formatter.date(from: string) ?? Date()
}
