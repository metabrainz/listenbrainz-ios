//
//  AdaptiveImage.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 16/01/24.
//

import SwiftUI

struct AdaptiveImage: View {
  @Environment(\.colorScheme) var colorScheme
  let light: Image
  let dark: Image

  @ViewBuilder var body: some View {
    if colorScheme == .light {
      light
    } else {
      dark
    }
  }
}

#Preview {
    AdaptiveImage(
        light: Image("listenBrainzLight"),
        dark: Image("listenBrainzDark")
    )
}
