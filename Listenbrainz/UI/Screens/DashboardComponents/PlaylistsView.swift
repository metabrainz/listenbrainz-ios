//
//  PlaylistsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    @Environment(\.colorScheme) var colorScheme
  @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if viewModel.playlists.isEmpty {
                    Text("No playlists available")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(viewModel.playlists, id: \.identifier) { playlist in
                        if let playlistId = viewModel.extractPlaylistId(from: playlist.identifier) {
                            NavigationLink(
                                destination: PlaylistDetailsView(
                                    playlistId: playlistId,
                                    playlistName: playlist.title
                                ).environmentObject(viewModel)
                            ) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(playlist.title)
                                        .font(.system(size: 30))
                                        .foregroundColor(colorScheme == .dark ? .white : .black)
                                    Text(playlist.annotation ?? "")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.lightPink)
                                    Text("Created: \(formattedDate(playlist.date))")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.lightPink)
                                    Text("Last modified: \(formattedDate(playlist.extensionData.playlistInfo.lastModifiedAt))")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(Color.lightPink)
                                }
                                .padding()
                                .frame(width: UIScreen.main.bounds.size.width - 10, height: 200)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getPlaylists(username: userName)
        }
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
}



