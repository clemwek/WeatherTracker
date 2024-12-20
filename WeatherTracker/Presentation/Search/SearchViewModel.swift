//
//  SearchViewModel.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var results: [City] = []
    @Published var state: State = .idle
    
    enum State {
        case idle
        case searching
        case error(String)
    }
    
    var searchCityUseCase: SearchCityUseCase
    
    init(searchCityUseCase: SearchCityUseCase) {
        self.searchCityUseCase = searchCityUseCase
    }
    
    func search() async {
        guard !query.isEmpty else { return }
        state = .searching
        let result = await searchCityUseCase.execute(query: query)
        switch result {
        case .success(let cities):
            self.results = cities
            state = .idle
        case .failure(let error):
            state = .error(error.localizedDescription)
        }
    }
}
