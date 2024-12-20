//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    private let container = DependencyContainer.live()
    
    var body: some View {
        HomeView(repository: container.weatherRepository,
                 storage: container.storage)
    }
}

#Preview {
    ContentView()
}
