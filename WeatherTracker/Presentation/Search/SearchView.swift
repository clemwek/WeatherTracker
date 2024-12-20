//
//  SearchView.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    var onCitySelected: (String) -> Void
    var query: String = ""

    init(
        onCitySelected: @escaping (String) -> Void,
        repository: WeatherRepositoryProtocol, query: String
    ) {
        self.onCitySelected = onCitySelected
        self.query = query
//        $viewModel.query. = query
        _viewModel = StateObject(
            wrappedValue: SearchViewModel(
                searchCityUseCase: SearchCityUseCase(repository: repository)))
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(
                    text: $viewModel.query,
                    placeholder: "Search Location",
                    onCommit: {
                        Task { await viewModel.search() }
                    }
                )
                .padding()

                switch viewModel.state {
                case .idle:
                    if viewModel.results.isEmpty && !viewModel.query.isEmpty {
                        Text("No results found.")
                            .foregroundColor(.secondaryText)
                            .padding()
                        Spacer()
                    } else if viewModel.results.isEmpty {
                        Spacer()
                        // Empty search state if needed
                    } else {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(viewModel.results) { city in
                                    Button {
                                        onCitySelected(city.name)
                                        dismissSheet()
                                    } label: {
                                        SearchResultView(city: city)
                                            .padding(.horizontal)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.top)
                        }
                    }
                case .searching:
                    ProgressView("Searching...")
                        .padding()
                    Spacer()
                case .error(let message):
                    Text("Error: \(message)")
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.query = query
            Task { await viewModel.search() }
        }
    }

    private func dismissSheet() {
        if let windowScene = UIApplication.shared.connectedScenes.first
            as? UIWindowScene
        {
            windowScene.windows.first?.rootViewController?.dismiss(
                animated: true)
        }
    }
}

#Preview {
    let test: (String) -> Void = { _ in }
    let container = DependencyContainer.live()
    SearchView(onCitySelected: test, repository: container.weatherRepository, query: "")
}
