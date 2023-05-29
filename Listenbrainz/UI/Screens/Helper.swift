//
//  Helper.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 10/05/23.
//

import Foundation
import SwiftUI

struct Helper {
  static let screenWidth = UIScreen.main.bounds.size.width
  static let screenHeight = UIScreen.main.bounds.size.height

  static private var backgroundColors: Set<Color> = [Color.accentColor,
                                                     Color.accentColor,
                                                     Color.green,
                                                     Color.gray,
                                                     Color.purple,
                                                     Color.blue,
                                                     Color.brown,
                                                     Color.cyan,
                                                     Color.indigo,
                                                     Color.mint,
                                                     Color.orange,
                                                     Color.pink,
                                                     Color.red,
                                                     Color.teal,
                                                     Color.yellow]
  static func getRandomColor() -> Color {
    return backgroundColors.randomElement()!
  }


}
