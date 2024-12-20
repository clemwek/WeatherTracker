//
//  SearchBarView.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String
    var onCommit: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            TextField(placeholder,
                      text: $text,
                      onCommit: {
                            onCommit?()
                        })
            .padding(.horizontal)
            .frame(height: 48)
            .background(Color.lightGrayBackground)
            .cornerRadius(12)
            .overlay(
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
            )
        }
    }
}

#Preview {
    SearchBarView(text: .constant(""), placeholder: "Search Location")
}
