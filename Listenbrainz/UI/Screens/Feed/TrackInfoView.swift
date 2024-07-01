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
    @State private var showPinTrackView = false
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State private var showingRecommendToUsersPersonallyView = false

     private var isRecordingRecommendation: Bool {
         return (item as? Event)?.eventType == "recording_recommendation"
     }

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

          if isRecordingRecommendation {
            Button(action: {
              if let event = item as? Event {
                feedViewModel.deleteEvent(userName: userName, eventID: event.id ?? 1, userToken: userToken)
              }
            }) {
              Image(systemName: "trash")
                .foregroundColor(.red)
                .padding(.horizontal, 10)
            }
          }

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
                    showPinTrackView = true
                }
                Button("Recommend to my followers") {
                  feedViewModel.recommendToFollowers(userName: userName, item: item, userToken: userToken)
                }
                Button("Personally recommend") {
                  showingRecommendToUsersPersonallyView = true
                }
                Button("Write a review") {
                    // Action for Write a review
                }

            } label: {
                Image(systemName: "ellipsis")
                    .padding(.horizontal, 10)
                    .rotationEffect(.degrees(90))
            }
        }
        .sheet(isPresented: $showPinTrackView) {
            PinTrackView(
                item: item,
                userToken: userToken
            )
            .environmentObject(feedViewModel)
        }
        .sheet(isPresented: $showingRecommendToUsersPersonallyView) {
          RecommendToUsersPersonallyView(item: item, userName: userName, userToken: userToken)
            .environmentObject(feedViewModel)
        }
    }
}








