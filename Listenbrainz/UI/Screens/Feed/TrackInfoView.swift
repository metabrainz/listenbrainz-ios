//
//  TrackInfoView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//

import SwiftUI

struct TrackInfoView: View {
  let event: Event
  @StateObject private var imageLoader = ImageLoader.shared
  @State private var isLoading = true

  var body: some View {
    HStack {
      if let coverArtURL = event.metadata.trackMetadata?.coverArtURL {
        AsyncImage(
          url: coverArtURL,
          scale: 0.1,
          transaction: Transaction(animation: nil),
          content: { phase in
            switch phase {
            case .success(let image):
              image
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .onAppear {
                  imageLoader.loadImage(url: coverArtURL) { loadedImage in
                    if let uiImage = loadedImage {
                      ImageCache.shared.insertImage(uiImage, for: coverArtURL)
                    }
                  }
                }
            default:
              if let cachedImage = ImageCache.shared.image(for: coverArtURL) {
                Image(uiImage: cachedImage)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 60, height: 60)
              } else {
                Image(systemName: "music.note")
                  .resizable()
                  .renderingMode(.template)
                  .foregroundColor(.orange)
                  .scaledToFit()
                  .frame(width: 60, height: 60)
              }
            }
          }
        )
        .frame(width: 60, height: 60)
      } else {
        Image(systemName: "music.note")
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.orange)
          .scaledToFit()
          .frame(width: 60, height: 60)
      }

      VStack(alignment: .leading) {
        Text(event.metadata.trackMetadata?.trackName ?? "Unknown Track")
          .lineLimit(1)
          .font(.headline)
        Text(event.metadata.trackMetadata?.artistName ?? "Unknown Artist")
          .lineLimit(1)
      }
    }
  }
}
