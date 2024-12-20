//
//  SearchResultView.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import SwiftUI

struct SearchResultView: View {
    let city: City
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(city.name)
                    .font(.cityFont())
                    .foregroundColor(.primaryText)
                if let region = city.region, let country = city.country {
                    Text("\(region), \(country)")
                        .font(.infoValueFont())
                        .foregroundColor(.secondaryText)
                }
            }
            Spacer()
        }
        .frame(height: 60)
        .background(Color.lightGrayBackground)
        .cornerRadius(12)
    }
}

#Preview {
    SearchResultView(city: City(name: "London", region: "England", country: "United Kingdom"))
}
