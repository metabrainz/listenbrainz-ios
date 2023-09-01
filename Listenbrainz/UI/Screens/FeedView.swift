//
//  FeedView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.events, id: \.id) { event in
                    VStack(alignment: .leading, spacing: 4) {
                      Text(eventDescription(for: event))
                          .font(.headline)
                          .foregroundColor(.blue)
                        HStack {
                            Image(systemName: "music.note")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.orange)
                                .scaledToFit()
                                .frame(height: 22)
                                .padding(4)

                            VStack(alignment: .leading) {
                                Text(trackName(for: event))
                                    .lineLimit(1)
                                    .font(.headline)
                                Text(artistName(for: event))
                                    .lineLimit(1)
                                    .foregroundColor(.secondary)
                            }
                        }

                    }
                }
            }
            .onAppear {
                viewModel.fetchFeedEvents(username: "gb1307")
            }
            .navigationTitle("Feed")
        }

    }

    private func trackName(for event: Event) -> String {
        return event.metadata.trackMetadata?.trackName ?? "Unknown Track"
    }

    private func artistName(for event: Event) -> String {
        return event.metadata.trackMetadata?.artistName ?? "Unknown Artist"
    }

    private func eventDescription(for event: Event) -> String {
        switch event.eventType {
            case "listen":
                return "\(event.userName) listened to a track"
            case "recording_recommendation":
                return "\(event.userName) recommended a track"
            case "critiquebrainz_review":
                return "\(event.userName) reviewed a track"
        case "recording_pin":
            return "\(event.userName) pinned a track"

            default:
                return "An event occurred"
        }
    }

}
