//
//  City.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    let name: String
    let region: String?
    let country: String?
}
