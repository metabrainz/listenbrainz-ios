//
//  Theme.swift
//  Listenbrainz
//
//  Created by Jasjeet Singh on 13/04/25.
//

import SwiftUI

class Theme: ObservableObject {
    @Published var isDarkMode: Bool = true {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: Strings.AppStorageKeys.isDarkMode)
        }
    }
    
    init() {
        isDarkMode = UserDefaults.standard.bool(forKey: Strings.AppStorageKeys.isDarkMode)
    }
    
    var systemColorScheme: ColorScheme? {
        isDarkMode ? .dark : .light
    }
    
    private let darkColors = DarkColors()
    private let lightColors = LightColors()
    var colorScheme: AppColorScheme {
        isDarkMode ? darkColors : lightColors
    }
    
    let spacings = Spacings()
}

// Spacings

struct Spacings {
    let screenBottom: CGFloat = 12
}

// Colors

protocol AppColorScheme {
    var background: Color { get }
}

struct DarkColors: AppColorScheme {
    let background: Color = Color.blue//Color(hex: "FF292929")
}

struct LightColors: AppColorScheme {
    let background: Color = Color.white
}
