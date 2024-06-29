//
//  TrackInfoView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//


import SwiftUI

struct TrackInfoView<T: TrackMetadataProvider>: View {
    let item: T
    @StateObject private var imageLoader = ImageLoader.shared

    var body: some View {
        HStack {
            if let coverArtURL = item.coverArtURL {
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
                Text(item.trackName ?? "Unknown Track")
                    .lineLimit(1)
                    .font(.headline)
                Text(item.artistName ?? "Unknown Artist")
                    .lineLimit(1)
            }

            Spacer()

            Menu {
                if let originURL = item.originURL {
                    Button("Open in Spotify") {
                        if let url = URL(string: originURL) {
                            UIApplication.shared.open(url)
                        }
                    }
                }

                if let recordingMbid = item.recordingMbid {
                    Button("Open in MusicBrainz") {
                        if let url = URL(string: "https://musicbrainz.org/recording/\(recordingMbid)") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
              Button("Pin this track") {
                // Action for Pin this track
              }
              Button("Recommend to my followers") {
                // Action for Recommend to my followers
              }
              Button("Personally recommend") {
                // Action for Personally recommend
              }
              Button("Write a review") {
                // Action for Write a review
              }
            } label: {
                Image(systemName: "ellipsis")
                    .padding(.horizontal, 10)
            }
        }
    }
}

protocol TrackMetadataProvider {
    var trackName: String? { get }
    var artistName: String? { get }
    var coverArtURL: URL? { get }
    var originURL: String? { get }
    var recordingMbid: String? { get }
}

extension Event: TrackMetadataProvider {
    var trackName: String? { metadata.trackMetadata?.trackName }
    var artistName: String? { metadata.trackMetadata?.artistName }
    var coverArtURL: URL? { metadata.trackMetadata?.coverArtURL }
    var originURL: String? { metadata.trackMetadata?.additionalInfo?.originURL }
    var recordingMbid: String? { metadata.trackMetadata?.additionalInfo?.recordingMbid }
}

extension Listen: TrackMetadataProvider {
    var trackName: String? { trackMetadata?.trackName }
    var artistName: String? { trackMetadata?.artistName }
    var coverArtURL: URL? { trackMetadata?.coverArtURL }
    var originURL: String? { trackMetadata?.additionalInfo?.originURL }
    var recordingMbid: String? { trackMetadata?.mbidMapping?.recordingMbid }
}
