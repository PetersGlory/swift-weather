import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showSearch = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if let error = viewModel.error, viewModel.weather == nil {
                        errorState(error)
                    }

                    if viewModel.isLoading && viewModel.weather == nil {
                        loadingState
                    }

                    if let weather = viewModel.weather {
                        currentWeatherSection(weather)
                        hourlySection(weather.hourly)
                        dailySection(weather.daily)
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(viewModel.cityName.isEmpty ? "Weather" : viewModel.cityName)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSearch = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                SearchView { city in
                    viewModel.loadWeatherForCity(city)
                }
            }
        }
    }

    private func currentWeatherSection(_ weather: WeatherResponse) -> some View {
        NavigationLink(destination: DetailView(weather: weather)) {
            VStack(spacing: 16) {
                Image(systemName: WeatherIconMapper.iconName(for: weather.current.weatherCode))
                    .font(.system(size: 72))
                    .foregroundStyle(.primary)

                Text("\(Int(weather.current.temperature2m))°")
                    .font(.system(size: 72, weight: .thin))

                Text(WeatherIconMapper.description(for: weather.current.weatherCode))
                    .font(.title3)
                    .foregroundStyle(.secondary)

                HStack(spacing: 24) {
                    MetricView(label: "Feels Like", value: "\(Int(weather.current.apparentTemperature))°")
                    MetricView(label: "Humidity", value: "\(weather.current.relativeHumidity2m)%")
                    MetricView(label: "Wind", value: "\(Int(weather.current.windSpeed10m)) km/h")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }

    private func hourlySection(_ hourly: HourlyForecast) -> some View {
        HourlyForecastView(hourly: hourly)
    }

    private func dailySection(_ daily: DailyForecast) -> some View {
        DailyForecastView(daily: daily)
    }

    private func loadingState() -> some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading weather...")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 300)
    }

    private func errorState(_ message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(message)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 300)
    }
}

private struct MetricView: View {
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
