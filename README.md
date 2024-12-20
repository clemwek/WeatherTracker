# WeatherTracker

WeatherTracker is an iOS application built using Swift and SwiftUI that allows users to search for a city and view its current weather conditions. The app fetches data from WeatherAPI.com and persists the user's selected city across launches.

## Features

__City Search:__ Users can search for any city using the integrated search field.

__Current Weather Display:__ Shows city name, temperature, weather condition (with icon), humidity, UV index, and "feels like" temperature.

__Persistence:__ The selected city is stored locally (using UserDefaults), so it will automatically load on subsequent app launches.

__Clean Architecture:__ The code is organized into separate layers (Domain, Data, Presentation) and uses MVVM, dependency injection, and protocol-oriented programming.
## Technology Stack

Language: Swift (5.7+)
UI Framework: SwiftUI
Architecture: MVVM with Use Cases
Data Persistence: UserDefaults
Networking: URLSession with async/await
API: WeatherAPI.com for current weather data and city search.
## Requirements

Xcode: 14.0 or later
iOS: 15.0 or later
A valid WeatherAPI.com API key (Free plan is sufficient)
## Setup and Installation

Clone the repository:
git clone [repo](https://github.com/clemwek/WeatherTracker.git)
Open the project: Open WeatherTracker.xcodeproj in Xcode.
Insert your API key: In DependencyContainer.swift, replace <YOUR_WEATHER_API_KEY> with your actual WeatherAPI key.
let apiKey = "<YOUR_WEATHER_API_KEY>"
Build and Run: Select a simulator or a physical device and run the app (Command + R).
## Usage

Initial Launch: If no city is saved, you’ll be prompted to search for one.
Searching for a City: Enter a city name in the search bar, then select a search result. The home screen will update with that city's weather.
Persisted City: On subsequent launches, the last selected city's weather will be displayed automatically.

## Project Structure

WeatherTracker/
    ContentView.swift
    WeatherTrackerApp.swift
    AppDependencies/
        DependencyContainer.swift
    Domain/
        Models/
            Weather.swift
            City.swift
        UseCases/
            FetchWeatherUseCase.swift
            SearchCityUseCase.swift
    Data/
        Networking/
            WeatherAPI.swift
            WeatherRepository.swift
        Storage/
            UserDefaultsStorage.swift
    Presentation/
        Home/
            HomeView.swift
            HomeViewModel.swift
        Search/
            SearchView.swift
            SearchViewModel.swift
        Components/
            WeatherInfoView.swift
            SearchResultView.swift
            SearchBarView.swift
    Assets.xcassets/
        AccentColor.colorset/
        |   Contents.json 

## Design and UI

The UI layout and styling is based on a provided Figma design (not included in this repo).
The app uses a modern SwiftUI layout with a clean, minimalistic design, large typography, and subtle background colors for enhanced readability.
## Known Issues / Future Improvements

__Error Handling:__ Further refine error messages or introduce user-friendly alerts.

__Offline Mode:__ Cache last known weather data for offline viewing.

__Localization:__ Add support for multiple languages.

__Unit Tests Coverage:__ Expand test coverage to include more edge cases.
## License

This project is distributed under the MIT License. Feel free to use and modify it according to your needs.