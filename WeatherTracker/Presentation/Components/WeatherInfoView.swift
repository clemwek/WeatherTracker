//
//  WeatherInfoView.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import SwiftUI

struct WeatherInfoView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.infoLabelFont())
                .foregroundColor(.secondaryText)
            Text(value)
                .font(.infoValueFont())
                .foregroundColor(.primaryText)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#Preview {
    WeatherInfoView(title: "Title", value: "Value")
}
