# Weather App

## Project Overview

Build a weather application that fetches live weather data from a public REST API and displays current weather conditions and forecasts.

The project should demonstrate networking, JSON decoding, asynchronous programming, and API integration using modern Swift practices.

---

# Objectives

Evaluate:

* REST API integration
* Async/Await
* JSON parsing
* MVVM architecture
* Error handling
* SwiftUI UI development

---

# Technical Requirements

## Language

* Swift 5+

## Frameworks

* SwiftUI
* URLSession

## Minimum iOS Version

* iOS 16+

---

# API Requirements

Use one of:

* OpenWeather API
* WeatherAPI
* Open-Meteo API

Developer should create an abstraction layer to allow API replacement later.

---

# Core Features

## Current Weather

Display:

* City name
* Current temperature
* Weather condition
* Humidity
* Wind speed
* Feels-like temperature

---

## Forecast

Display:

* Hourly forecast
* Daily forecast

Requirements:

* Scrollable forecast cards
* Dynamic weather icons

---

## City Search

Allow users to:

* Search city
* Load weather for selected city

Requirements:

* Search bar
* API-driven search

---

## Loading States

Show:

* Activity indicator
* Skeleton loader (optional)

---

## Error Handling

Handle:

* No internet
* Invalid response
* API failure
* Empty search results

Display user-friendly messages.

---

# Networking Requirements

Use:

* URLSession

Implement:

* GET requests
* Async/Await
* Generic network manager

Example Architecture:

NetworkManager
APIClient
WeatherService

---

# JSON Decoding

Use:

* Codable

Requirements:

* Strongly typed models
* Proper decoding strategies
* No manual parsing

---

# Architecture

Use MVVM.

Structure:

Project
├── Models
├── Services
├── Network
├── ViewModels
├── Views
└── Utilities

---

# UI Requirements

## Home Screen

Display:

* Current weather
* Weather icon
* Forecast section

---

## Search Screen

Display:

* Search bar
* Search results

---

## Details Screen

Display:

* Additional weather metrics

Examples:

* UV index
* Pressure
* Visibility
* Sunrise
* Sunset

---

# Caching

Implement basic caching.

Possible solutions:

* UserDefaults
* Local file storage

Store:

* Last searched city
* Last weather response

---

# Deliverables

Developer must provide:

* Complete source code
* API integration
* README setup guide
* Screenshots
* Environment configuration instructions

---

# Bonus Features

Optional:

* Geolocation support
* Pull-to-refresh
* Weather animations
* Dark mode
* Offline mode
* Multiple saved cities

---

# Evaluation Criteria

* Networking implementation
* Async/Await usage
* Error handling
* Code quality
* MVVM structure
* UI design
* Performance
