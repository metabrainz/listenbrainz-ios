//
//  PersonallyRecommendView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 01/07/24.
//

import SwiftUI

struct RecommendToUsersPersonallyView: View {
  @State private var blurbContent: String = ""
  @State private var users: String = ""
  var item: TrackMetadataProvider
  var userName: String
  var userToken: String
  @EnvironmentObject var viewModel: FeedViewModel
  var dismissAction: () -> Void

  var body: some View {
    VStack(alignment:.leading, spacing:10) {

      Text("Recommend \(item.trackName ?? "")")



      TextField("Add Followers", text: $users)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())

      Text("Leave a message (optional)")


      TextField("You will love this song because...", text: $blurbContent)
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())

      HStack {
          Spacer()
          Text("\(blurbContent.count) / 280")
              .font(.caption)
              .foregroundColor(.gray)
      }




      HStack {
        Spacer()
        Button(action: {
          dismissAction()
        }) {
          Text("Cancel")
            .padding()
        }

        Button(action: {
          let usersArray = users.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
          viewModel.recommendToUsersPersonally(userName: userName, item: item, users: usersArray, blurbContent: blurbContent, userToken: userToken)
          dismissAction()
        }) {
          Text("Send recommendation")
            .padding()
            .background(Color.yimGreen)
            .foregroundColor(.white)
        }

      }
      .padding()
    }
  }
}
