import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private(set) var results: [CityResult] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String?

    private let weatherService: WeatherServiceProtocol
    private var searchTask: Task<Void, Never>?

    init(weatherService: WeatherServiceProtocol = WeatherService.shared) {
        self.weatherService = weatherService
    }

    func search(query: String) {
        searchTask?.cancel()

        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            results = []
            error = nil
            return
        }

        searchTask = Task {
            isLoading = true
            error = nil

            do {
                try await Task.sleep(nanoseconds: 300_000_000)
                guard !Task.isCancelled else { return }

                let cities = try await weatherService.searchCity(query: query)
                guard !Task.isCancelled else { return }

                if cities.isEmpty {
                    error = "No cities found"
                }
                results = cities
            } catch let networkError as NetworkError {
                if !Task.isCancelled {
                    error = networkError.errorDescription
                }
            } catch {
                if !Task.isCancelled {
                    error = error.localizedDescription
                }
            }

            isLoading = false
        }
    }
}
