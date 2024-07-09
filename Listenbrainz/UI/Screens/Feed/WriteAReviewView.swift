//
//  WriteAReviewView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 08/07/24.
//

import SwiftUI

struct WriteAReviewView<T: TrackMetadataProvider>: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @State private var text: String = ""
    @State private var rating: Int = 0
    @State private var language: String = "en"
    @Binding var isPresented: Bool
    var item: T
    var userToken: String
    var userName: String
    var dismissAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Write a Review")
                .font(.headline)

            TextField("Your Review", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.vertical)

            Picker("Rating (optional):", selection: $rating) {
                ForEach(1..<6) { index in
                    Text("\(index) Star\(index > 1 ? "s" : "")").tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)

            Picker("Language of your review:", selection: $language) {
                ForEach(["English", "Spanish", "French", "German", "Chinese"], id: \.self) { lang in
                    Text(lang).tag(lang)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.vertical)

            Button(action: {
                writeReview()
                dismissAction()
            }) {
                Text("Submit Review")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    private func writeReview() {
        guard let recordingMsid = item.recordingMsid else {
            print("Missing recording MSID")
            return
        }
        viewModel.writeAReview(
            userName: userName,
            item: item,
            userToken: userToken,
            entityName: item.trackName ?? "Unknown",
            entityId: recordingMsid,
            entityType: "recording",
            text: text,
            language: language,
            rating: rating
        )
    }
}

