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
    
    let sizes = Sizes()
}

// Sizes

struct Sizes {
    let shadowRadius: CGFloat = 2
}

// Spacings

struct Spacings {
    let screenBottom: CGFloat = 12
    let horizontal: CGFloat = 8
}

// Colors

protocol AppColorScheme {
    var background: Color { get }
    var onBackground: Color { get }
    var level1: Color { get }
    var level2: Color { get }
    var lbSignature: Color { get }
    var lbSignatureSecondary: Color { get }
    var lbSignatureInverse: Color { get }
    var onLbSignature: Color { get }
    var text: Color { get }
    var listenText: Color { get }
    var hint: Color { get }
    var chipUnselected: Color { get }
    var chipSelected: Color { get }
}

struct DarkColors: AppColorScheme {
    let background: Color = Color(hex: "FF292929")
    let onBackground: Color = Color.white
    let level1: Color = Color.black
    let level2: Color = Color(hex: "FF3B3B3B")
    let lbSignature: Color = Color.lb_purple_night
    let lbSignatureSecondary: Color = Color.lb_yellow
    let lbSignatureInverse: Color = Color.lb_orange
    let onLbSignature: Color = Color.black
    let text: Color = Color.white
    let listenText: Color = Color.white
    let hint: Color = Color(hex: "FF8C8C8C")
    let chipSelected: Color = Color.black
    let chipUnselected: Color = Color(hex: "FF1E1E1E")
}

struct LightColors: AppColorScheme {
    let background: Color = Color.white
    let onBackground: Color = Color.black
    let level1: Color = Color.white
    let level2: Color = Color(hex: "FFE3E3E3")
    let lbSignature: Color = Color.lb_purple
    let lbSignatureSecondary: Color = Color.lb_yellow
    let lbSignatureInverse: Color = Color.lb_orange_day
    let onLbSignature: Color = Color.white
    let text: Color = Color.black
    let listenText: Color = Color.lb_purple
    let hint: Color = Color(hex: "FF707070")
    let chipSelected: Color = Color(hex: "FFB6B6B6")
    let chipUnselected: Color = Color.white
}
