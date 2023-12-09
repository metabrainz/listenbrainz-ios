//
//  TrackInfoView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//

import SwiftUI

struct TrackInfoView: View {
  let event: Event

  var body: some View {
    HStack {
      Image(systemName: "music.note")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(.orange)
        .scaledToFit()
        .frame(height: 22)
        .padding(4)

      VStack(alignment:.leading) {
        Text(event.metadata.trackMetadata?.trackName ?? "Unknown Track")
          .lineLimit(1)
          .font(.headline)
        Text(event.metadata.trackMetadata?.artistName ?? "Unknown Artist")
          .lineLimit(1)
          
      }
    }
  }
}
