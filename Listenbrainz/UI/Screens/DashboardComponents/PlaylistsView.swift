//
//  PlaylistsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
  @EnvironmentObject var userSelection: UserSelection
  let lightPink = Color(red: 0.75, green: 0.46, blue: 0.65)

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if viewModel.playlists.isEmpty {
                    Text("No playlists available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(viewModel.playlists, id: \.identifier) { playlist in
                      VStack(alignment: .leading, spacing: 8) {
                        Text(playlist.title)
                          .font(.system(size: 30))
                          .foregroundColor(.white)
                        Text(playlist.annotation ?? "")
                          .font(.system(size: 20, weight:.bold))
                          .foregroundColor(lightPink)
                        Text("Created: \(formattedDate(playlist.date))")
                          .font(.system(size: 20, weight:.bold))
                          .foregroundColor(lightPink)
                        Text("Last modified: \(formattedDate(playlist.extensionData.playlistInfo.lastModifiedAt))")
                          .font(.system(size: 20, weight:.bold))
                          .foregroundColor(lightPink)
                      }
                        .padding()
                        .frame(width:UIScreen.main.bounds.size.width - 10, height: 200)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .onTapGesture {
                            openPlaylistLink(playlist.identifier)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getPlaylists(username: userSelection.selectedUserName)
        }
        .navigationTitle("Playlists")
    }

  private func formattedDate(_ dateString: String) -> String {
       let formatter = ISO8601DateFormatter()
       formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

       if let date = formatter.date(from: dateString) {
           let displayFormatter = DateFormatter()
           displayFormatter.dateFormat = "dd/MM/yyyy"
           return displayFormatter.string(from: date)
       }
       return dateString
   }

    func openPlaylistLink(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
