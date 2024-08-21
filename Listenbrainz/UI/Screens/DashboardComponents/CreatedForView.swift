//
//  CreatedForView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//


import SwiftUI

struct CreatedForYouView: View {
  @EnvironmentObject var viewModel: DashboardViewModel
  @EnvironmentObject var userSelection: UserSelection
  @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""

  var body: some View {
    ScrollView{
      VStack(alignment: .leading) {
        ForEach(viewModel.createdForYou.indices, id: \.self) { index in
          let playlist = viewModel.createdForYou[index]
          let imageName = "green-\(index + 1)"

          ZStack(alignment:.leading) {
            Image(imageName)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(height: 200)
              .clipped()

            Text(playlist.title.components(separatedBy: ",").first ?? "")
              .font(.system(size: 30, weight: .bold))
              .padding()
              .foregroundColor(Color.LbPurple)
          }
          .onTapGesture {
            openPlaylistLink(playlist.identifier)
          }
          .cornerRadius(10)
          .shadow(radius: 5)
          .padding(.vertical, 8)
        }
      }
      .onAppear {
        viewModel.getCreatedForYou(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
      }
    }
  }

    func openPlaylistLink(_ urlString: String) {
      if let url = URL(string: urlString) {
        UIApplication.shared.open(url)
      }
    }
  }

