# Swift Weather

A SwiftUI weather application that fetches live weather data from the [Open-Meteo API](https://open-meteo.com/) (free, no API key required). Built with MVVM architecture, async/await networking, and SwiftUI.

## Features

- **Current Weather** — Temperature, feels-like, humidity, wind speed, pressure, visibility, and weather condition with SF Symbol icons.
- **Hourly Forecast** — Horizontally scrollable cards for the next 24 hours with temperature and precipitation probability.
- **7-Day Forecast** — Vertical list with high/low temperatures, weather condition descriptions, sunrise/sunset times, and UV index.
- **City Search** — API-driven geocoding lookup via Open-Meteo Geocoding API with debounced search and results showing city, region/state, and country.
- **Detail View** — Expanded weather metrics including pressure, visibility, UV index, sunrise, and sunset.
- **Caching** — Last viewed city and weather response persisted in `UserDefaults` for launch restoration.
- **Error Handling** — User-friendly messages for network failures, API errors, decoding failures, and empty search results.
- **Loading States** — `ProgressView` indicators during network requests.
- **Dark Mode** — Native support via SwiftUI dynamic system colors.
- **No External Dependencies** — Uses only Apple frameworks (`SwiftUI`, `Foundation`, `URLSession`).

## Architecture

MVVM (Model-View-ViewModel) with protocol-oriented service abstraction.

```
Sources/
├── Models/
│   ├── WeatherResponse.swift        # Open-Meteo forecast API models
│   └── CitySearchResponse.swift     # Geocoding API models
├── Network/
│   ├── APIEndpoint.swift            # Endpoint enum with URL construction
│   ├── APIClient.swift              # Generic actor-based API client
│   └── NetworkError.swift           # Custom error types
├── Services/
│   ├── WeatherServiceProtocol.swift  # Service abstraction
│   └── WeatherService.swift          # Concrete implementation (singleton)
├── ViewModels/
│   ├── WeatherViewModel.swift        # Weather data state management
│   └── SearchViewModel.swift         # City search state management
├── Views/
│   ├── ContentView.swift             # Root view
│   ├── HomeView.swift                # Main weather display
│   ├── DetailView.swift              # Extended metrics screen
│   ├── SearchView.swift              # City search sheet
│   ├── HourlyForecastView.swift      # Horizontal scroll forecast
│   └── DailyForecastView.swift       # 7-day vertical forecast
├── Utilities/
│   ├── WeatherIconMapper.swift       # WMO code → SF Symbol + description
│   └── CacheManager.swift            # UserDefaults caching
├── Info.plist                        # Bundle configuration
└── swift_weatherApp.swift            # @main app entry point
```

### Key Design Decisions

- **`APIClient`** is an `actor` for thread-safe network access.
- **`WeatherServiceProtocol`** enables dependency injection and testability.
- **ViewModels** accept `WeatherServiceProtocol` and `CacheManager` in initializers with default singleton instances, allowing mock injection.
- **`WeatherIconMapper`** translates [WMO weather codes](https://open-meteo.com/en/docs#weathervariables) to SF Symbols and localized descriptions.

## Requirements

- iOS 16.0+
- Xcode 14+ (Swift 5.7)
- Network connection (for initial data fetch)

## Setup

This project uses Swift Package Manager and has no `.xcodeproj` or `.xcworkspace`. Open it directly in Xcode:

```bash
open Package.swift
```

Then select an iOS 16+ simulator and press **Run**.

### Build via command line

```bash
xcodebuild -scheme swift-weather -destination 'platform=iOS Simulator,name=iPhone 16'
```

## API Reference

| Endpoint | Usage |
|---|---|
| `https://api.open-meteo.com/v1/forecast` | Weather forecast (current, hourly, daily) |
| `https://geocoding-api.open-meteo.com/v1/search` | City name autocomplete |

**No API key is required.** Open-Meteo is a free, open-source weather API.

## Testing

No test targets are currently configured. The architecture supports testability via `WeatherServiceProtocol` and constructor-based dependency injection.

## License

Unlicense — see the [Guide.MD](Guide.MD) for original project requirements.
