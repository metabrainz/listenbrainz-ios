//
//  PlaylistsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    @EnvironmentObject var theme: Theme
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: theme.spacings.vertical) {
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
                                PlaylistCardView(
                                    playlist: playlist,
                                    playlistId: playlistId
                                )
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getPlaylists(username: userName)
        }
    }
}

struct PlaylistCardView: View {
    @EnvironmentObject var theme: Theme
    
    let playlist: Playlist
    let playlistId: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(playlist.title)
                .font(.system(size: 30))
                .foregroundColor(theme.colorScheme.text)
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
        .frame(maxWidth: UIScreen.main.bounds.width)
        .padding()
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, theme.spacings.horizontal)
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
