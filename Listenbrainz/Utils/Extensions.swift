//
//  Extensions.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 18/11/23.
//

import Foundation
import SwiftUI

extension Color{

  static let primary = Color(red: 0.86, green: 0.49, blue: 0.29)
  static let secondary = Color(red: 0.20, green: 0.19, blue: 0.42)
  static let yimBeige = Color(red: 0.94, green: 0.93, blue: 0.89)
  static let yimGreen = Color(red: 0.3, green: 0.43, blue: 0.32)
  static let yimRed = Color(red: 0.75, green: 0.29, blue: 0.33)
  static let yimAqua = Color(red: 0.34, green: 0.45, blue: 0.46)
  static let yimBrown = Color(red: 0.30, green: 0.27, blue: 0.26)
  static let backgroundColor = Color(red: 0.16, green: 0.16, blue: 0.16)
  static let lightPink = Color(red: 0.75, green: 0.46, blue: 0.65)
    static let lb_orange = Color(hex: "FFEA743B")
    static let lb_purple = Color(hex: "FF353070")
    static let lb_yellow = Color(hex: "FFE59B2E")
    static let lb_purple_night = Color(hex: "FF9AABD1")
    static let lb_orange_day = Color(hex: "FFE5743E")
}

// https://stackoverflow.com/questions/56874133/use-hex-color-in-swiftui
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct HeightModifier: ViewModifier {
    @Binding var size: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear.onAppear {
                        DispatchQueue.main.async {
                            size = geometry.size
                        }
                    }
                }
            )
    }
}

extension View {
    func readSize(_ size: Binding<CGSize>) -> some View {
        self.modifier(HeightModifier(size: size))
    }
    
    /** Adds scroll indicator padding or nothing if iOS version is above iOS 17. */
    func addScrollIndicatorPaddingTop(height: CGFloat) -> some View {
        if #available(iOS 17.0, *) {
            return self.contentMargins(.top, height, for: .scrollIndicators)
        } else {
            // Fallback on earlier versions
            return self
        }
    }
}
