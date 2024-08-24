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



struct PlaylistDetailsView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    var playlistId: String
    var playlistName: String
    @State private var isLoading = false
    @State private var selectedTrack: PlaylistTrack?
    @State private var showPinTrackView = false
    @State private var showWriteReview = false
    @State private var showingRecommendToUsersPersonallyView = false
    @Environment(\.colorScheme) var colorScheme

    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.backgroundColor : Color.white

                if isLoading {
                    ProgressView("Loading playlist details...")
                        .padding()
                } else {
                    if let details = viewModel.playlistDetails {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                              VStack(alignment:.leading,spacing:5){
                                Text(playlistName)
                                  .font(.largeTitle)
                                  .padding(.horizontal)

                                Text("Public Playlist by \(viewModel.userName)")
                                  .font(.title2)
                                  .fontWeight(.bold)
                                  .foregroundStyle(Color.lightPink)

                              }
                              .padding(.top,30)


                                ForEach(details.track, id: \.id) { track in
                                    TrackInfoView(
                                        item: track,
                                        onPinTrack: { track in
                                            selectedTrack = track
                                            showPinTrackView = true
                                        },
                                        onRecommendPersonally: { track in
                                            selectedTrack = track
                                            showingRecommendToUsersPersonallyView = true
                                        },
                                        onWriteReview: { track in
                                            selectedTrack = track
                                            showWriteReview = true
                                        }
                                    )
                                    .frame(width:  UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                    .background(colorScheme == .dark ? Color(.systemBackground).opacity(0.1) : Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                }
                            }
                            .padding(.top,50)
                        }
                    } else {
                        Text("No details available for this playlist.")
                            .foregroundColor(.gray)
                            .padding(.top)
                    }
                }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            fetchPlaylistDetails()
        }
        .centeredModal(isPresented: $showPinTrackView) {
            if let track = selectedTrack {
                PinTrackView(
                    isPresented: $showPinTrackView,
                    item: track,
                    userToken: userToken,
                    dismissAction: {
                        showPinTrackView = false
                    }
                )
                .environmentObject(viewModel)
            }
        }
        .centeredModal(isPresented: $showWriteReview) {
            if let track = selectedTrack {
                WriteAReviewView(
                    isPresented: $showWriteReview,
                    item: track,
                    userToken: userToken,
                    userName: userName
                ) {
                    showWriteReview = false
                }
                .environmentObject(viewModel)
            }
        }
        .centeredModal(isPresented: $showingRecommendToUsersPersonallyView) {
            if let track = selectedTrack {
                RecommendToUsersPersonallyView(
                    item: track,
                    userName: userName,
                    userToken: userToken,
                    dismissAction: {
                        showingRecommendToUsersPersonallyView = false
                    }
                )
                .environmentObject(viewModel)
            }
        }
    }

    private func fetchPlaylistDetails() {
        isLoading = true
        viewModel.getCreatedForYouPlaylist(playlistId: playlistId)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isLoading = false
        }
    }
}
