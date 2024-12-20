//
//  UserDefaultsStorage.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

class UserDefaultsStorage: StorageProtocol {
    private let defaults = UserDefaults.standard
    private let cityKey = "SelectedCity"
    
    var selectedCity: String? {
        get { defaults.string(forKey: cityKey) }
        set { defaults.setValue(newValue, forKey: cityKey) }
    }
}
