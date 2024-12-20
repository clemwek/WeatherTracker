//
//  Home+Extension.swift
//  WeatherTracker
//
//  Created by Clement  Wekesa on 12/19/24.
//

import SwiftUI

extension Color {
    static let lightGrayBackground = Color(white: 0.95)
    static let primaryText = Color.black
    static let secondaryText = Color.gray
}

// Example fonts - match with Figma (adjust sizes and weights as needed)
extension Font {
    static func titleFont() -> Font {
        .system(size: 28, weight: .semibold)
    }
    static func cityFont() -> Font {
        .system(size: 24, weight: .semibold)
    }
    static func largeTempFont() -> Font {
        .system(size: 64, weight: .semibold)
    }
    static func infoLabelFont() -> Font {
        .system(size: 16, weight: .regular)
    }
    static func infoValueFont() -> Font {
        .system(size: 14, weight: .regular)
    }
}
