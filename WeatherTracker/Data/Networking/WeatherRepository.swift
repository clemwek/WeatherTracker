//
//  WeatherRepository.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

struct WeatherRepository: WeatherRepositoryProtocol {
    let api: WeatherAPI
    
    func fetchWeather(for city: String) async throws -> Weather {
        let response = try await api.fetchWeather(for: city)
        return Weather(
            city: response.location.name,
            temperatureC: response.current.temp_c,
            condition: response.current.condition.text,
            iconURL: URL(string: "https:\(response.current.condition.icon)"),
            humidity: response.current.humidity,
            uvIndex: response.current.uv,
            feelsLikeC: response.current.feelslike_c
        )
    }
    
    func searchCity(query: String) async throws -> [City] {
        let response = try await api.searchCity(query: query)
        return response.map {
            City(name: $0.name, region: $0.region, country: $0.country)
        }
    }
}
