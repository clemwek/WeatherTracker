//
//  DependencyContainer.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeather(for city: String) async throws -> Weather
    func searchCity(query: String) async throws -> [City]
}

protocol StorageProtocol {
    var selectedCity: String? { get set }
}

struct DependencyContainer {
    let weatherRepository: WeatherRepositoryProtocol
    let storage: StorageProtocol
}

extension DependencyContainer {
    static func live() -> DependencyContainer {
        let apiKey = "59ffd2c7a5be4a6cb77114359241812"
        let weatherAPI = WeatherAPI(apiKey: apiKey)
        let storage = UserDefaultsStorage()
        return DependencyContainer(
            weatherRepository: WeatherRepository(api: weatherAPI),
            storage: storage
        )
    }
}
