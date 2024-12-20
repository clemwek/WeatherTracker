//
//  HomeViewModel.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var state: State = .idle
    @Published var showSearchPrompt = false
    @Published var query: String = ""
    @Published var showSearchResults = false
    
    enum State {
        case idle
        case loading
        case error(String)
    }
    
    private let fetchWeatherUseCase: FetchWeatherUseCase
    private var storage: StorageProtocol
    
    init(fetchWeatherUseCase: FetchWeatherUseCase, storage: StorageProtocol) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        self.storage = storage
        loadPersistedCity()
    }
    
    func loadPersistedCity() {
        guard let city = storage.selectedCity else {
            showSearchPrompt = true
            return
        }
        Task {
            await loadWeather(for: city)
        }
    }
    
    func loadWeather(for city: String) async {
        state = .loading
        print("Test the city \(city)")
        let result = await fetchWeatherUseCase.execute(for: city)
        switch result {
        case .success(let weather):
            currentWeather = weather
            storage.selectedCity = city
            showSearchPrompt = false
            state = .idle
        case .failure(let error):
            state = .error(error.localizedDescription)
        }
    }
    
    func fetchWeather() async {
        await loadWeather(for: query)
    }
}
