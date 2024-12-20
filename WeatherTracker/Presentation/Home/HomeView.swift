//
//  HomeView.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import SwiftUI

struct HomeView: View {
    let repository: WeatherRepositoryProtocol
    let storage: StorageProtocol
    @StateObject private var viewModel: HomeViewModel
    
    init(repository: WeatherRepositoryProtocol, storage: StorageProtocol) {
            self.repository = repository
            self.storage = storage
            _viewModel = StateObject(wrappedValue: HomeViewModel(
                fetchWeatherUseCase: FetchWeatherUseCase(repository: repository),
                storage: storage
            ))
        }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(
                    text: $viewModel.query,
                    placeholder: "Search Location",
                    onCommit: { viewModel.showSearchResults = true }
                )
                .padding([.leading, .trailing, .top])
                
                Spacer()
                
                if viewModel.showSearchPrompt, viewModel.currentWeather == nil {
                    VStack(spacing: 8) {
                        Text("No City Selected")
                            .font(Font.cityFont())
                            .foregroundColor(.primaryText)
                        Text("Please Search For A City")
                            .font(.infoValueFont())
                            .foregroundColor(.secondaryText)
                    }
                    Spacer()
                } else if let weather = viewModel.currentWeather {
                    VStack(spacing: 16) {
                        if let iconURL = weather.iconURL {
                            AsyncImage(url: iconURL) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                        } else {
                            Image(systemName: "sun.max")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.orange)
                        }
                        
                        HStack(spacing: 4) {
                            Text(weather.city)
                                .font(.cityFont())
                                .foregroundColor(.primaryText)
                            Image(systemName: "paperplane.fill")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .offset(y: -2)
                        }
                        
                        Text("\(Int(weather.temperatureC))°")
                            .font(.largeTempFont())
                            .foregroundColor(.primaryText)
                        
                        // Info Bar
                        HStack(spacing: 0) {
                            WeatherInfoView(title: "Humidity", value: "\(weather.humidity)%")
                            Divider().frame(height: 40)
                            WeatherInfoView(title: "UV", value: "\(Int(weather.uvIndex))")
                            Divider().frame(height: 40)
                            WeatherInfoView(title: "Feels Like", value: "\(Int(weather.feelsLikeC))°")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.lightGrayBackground)
                        .cornerRadius(12)
                        .padding([.leading, .trailing])
                    }
                    Spacer()
                } else if case .error(let message) = viewModel.state {
                    Text("Error: \(message)")
                        .foregroundColor(.red)
                    Spacer()
                } else {
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $viewModel.showSearchResults) {
                SearchView(onCitySelected: { city in
                    Task {
                        await viewModel.loadWeather(for: city)
                    }
                    viewModel.showSearchResults = false
                }, repository: repository, query: viewModel.query)
            }
        }
    }
}
#Preview {
    
    let container = DependencyContainer.live()
    HomeView(repository: container.weatherRepository,
             storage: container.storage)
}
