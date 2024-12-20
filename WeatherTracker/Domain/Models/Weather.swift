//
//  Weather.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let city: String
    let temperatureC: Double
    let condition: String
    let iconURL: URL?
    let humidity: Int
    let uvIndex: Double
    let feelsLikeC: Double
}
