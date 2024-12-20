//
//  FetchWeatherUseCase.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

struct FetchWeatherUseCase {
    let repository: WeatherRepositoryProtocol
    
    func execute(for city: String) async -> Result<Weather, Error> {
        do {
            let weather = try await repository.fetchWeather(for: city)
            return .success(weather)
        } catch {
            return .failure(error)
        }
    }
}
