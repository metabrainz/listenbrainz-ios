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
    @Binding  var isPresented: Bool
    var item: T
    var userToken: String
   var dismissAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Pin Track")
                .font(.headline)

            TextField("Blurb Content (optional)", text: $blurbContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical)

            Button(action: {
                pinTrack()
              dismissAction()
            }) {
                Text("Pin Track")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
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

