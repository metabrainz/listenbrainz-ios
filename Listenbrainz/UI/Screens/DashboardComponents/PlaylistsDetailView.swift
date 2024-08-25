//
//  PlaylistsDetailView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 24/08/24.
//

import SwiftUI


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

