//
//  SearchCityUseCase.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

struct SearchCityUseCase {
    let repository: WeatherRepositoryProtocol
    
    func execute(query: String) async -> Result<[City], Error> {
        do {
            let cities = try await repository.searchCity(query: query)
            return .success(cities)
        } catch {
            return .failure(error)
        }
    }
}
