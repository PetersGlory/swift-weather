import SwiftUI

struct DailyForecastView: View {
    let daily: DailyForecast

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("7-Day Forecast", systemImage: "calendar")

            VStack(spacing: 0) {
                ForEach(Array(zip(daily.time.indices, daily.time)), id: \.0) { index, _ in
                    DayRow(
                        day: daily.time[index],
                        high: daily.temperature2mMax[index],
                        low: daily.temperature2mMin[index],
                        code: daily.weatherCode[index]
                    )
                    if index < daily.time.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

private struct DayRow: View {
    let day: String
    let high: Double
    let low: Double
    let code: Int

    var body: some View {
        HStack(spacing: 12) {
            Text(dayLabel)
                .frame(width: 44, alignment: .leading)
                .font(.subheadline)
                .fontWeight(.medium)

            Image(systemName: WeatherIconMapper.iconName(for: code))
                .frame(width: 24)

            Text(WeatherIconMapper.description(for: code))
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)

            Spacer()

            HStack(spacing: 8) {
                Text("\(Int(high))°")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text("\(Int(low))°")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 10)
    }

    private var dayLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: day) else { return day }

        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        }
        if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        }
        let weekday = DateFormatter()
        weekday.dateFormat = "EEE"
        return weekday.string(from: date)
    }
}
