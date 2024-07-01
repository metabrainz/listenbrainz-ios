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
        VStack {
            TextField("Blurb Content", text: $blurbContent)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Users (comma separated)", text: $users)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                let usersArray = users.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
                viewModel.recommendToUsersPersonally(userName: userName, item: item, users: usersArray, blurbContent: blurbContent, userToken: userToken)
              dismissAction()
            }) {
                Text("Recommend Personally")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

