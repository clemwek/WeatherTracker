//
//  WeatherAPI.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

struct WeatherAPIResponse: Decodable {
    struct Current: Decodable {
        let temp_c: Double
        let condition: Condition
        let humidity: Int
        let uv: Double
        let feelslike_c: Double
    }
    struct Condition: Decodable {
        let text: String
        let icon: String
    }
    struct Location: Decodable {
        let name: String
    }
    let location: Location
    let current: Current
}

struct SearchAPIResponse: Decodable {
    struct SearchCityItem: Decodable {
        let name: String
        let region: String?
        let country: String?
    }
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var temp: [SearchCityItem] = []
        while !container.isAtEnd {
            if let item = try? container.decode(SearchCityItem.self) {
                temp.append(item)
            }
        }
        self.cities = temp
    }
    let cities: [SearchCityItem]
}

final class WeatherAPI {
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    func fetchWeather(for city: String) async throws -> WeatherAPIResponse {
        let urlStr = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)"
        guard let url = URL(string: urlStr) else { throw URLError(.badURL) }
        
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
    }
    
    func searchCity(query: String) async throws -> [SearchAPIResponse.SearchCityItem] {
        let urlStr = "https://api.weatherapi.com/v1/search.json?key=\(apiKey)&q=\(query)"
        guard let url = URL(string: urlStr) else { throw URLError(.badURL) }
        
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(SearchAPIResponse.self, from: data).cities
    }
}
