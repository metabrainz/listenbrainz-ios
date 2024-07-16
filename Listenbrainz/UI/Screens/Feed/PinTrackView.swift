//
//  PinTrackView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 01/07/24.
//

import SwiftUI

struct PinTrackView<T: TrackMetadataProvider>: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @State private var blurbContent: String = ""
    @Binding var isPresented: Bool
    var item: T
    var userToken: String
    var dismissAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Pin This Track to Your Profile")
                .font(.system(size: 20))

          Divider()

          if let trackName = item.trackName, let artistName = item.artistName {
              Text("Why do you love \(trackName) by \(artistName)?(Optional)")
          } else {
              Text("Some information is missing.")
          }

          DismissableTextView(text: $blurbContent)
            .frame(height: 150)
            .padding(.vertical, 5)

            HStack {
                Spacer()
                Text("\(blurbContent.count) / 280")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text("Pinning this track will replace any track currently pinned.\n\(item.trackName ?? "") by \(item.artistName ?? " ") will be unpinned from your profile in one week.")
                .font(.footnote)
                .foregroundColor(.gray)

            HStack {
                Button(action: {
                    dismissAction()
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                }

                Button(action: {
                    pinTrack()
                    dismissAction()
                }) {
                    Text("Pin track")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yimGreen)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 10)
        .padding()
    }

    private func pinTrack() {
        guard let recordingMsid = item.recordingMsid else {
            print("Missing recording MSID")
            return
        }
        let recordingMbid = item.recordingMbid
        viewModel.pinTrack(
            recordingMsid: recordingMsid,
            recordingMbid: recordingMbid,
            blurbContent: blurbContent,
            userToken: userToken
        )
    }
}

