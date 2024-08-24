//
//  CreatedForView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import SwiftUI

struct CreatedForYouView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    @State private var selectedPlaylistId: String?
    @State private var isLoading = false
    @State private var showPinTrackView = false
    @State private var showWriteReview = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var selectedTrack: PlaylistTrack?

    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
      ScrollView(.vertical){
        VStack(alignment: .leading) {
          Text("Created for \(viewModel.userName)")
            .font(.system(size: 20))
            .padding(.leading,20)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
              ForEach(viewModel.createdForYou.indices, id: \.self) { index in
                let playlist = viewModel.createdForYou[index]
                let imageName = "green-\(index + 1)"

                ZStack(alignment: .leading) {
                  Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width * 0.9, height: 200)
                    .clipped()
                    .shadow(radius: 5)

                  Text(playlist.title.components(separatedBy: ",").first ?? "")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.LbPurple)
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.size.width * 0.9 - 32)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .shadow(radius: 2)
                }
                .onAppear{
                  fetchPlaylistDetails(playlist.identifier)
                }
                .onTapGesture {
                  fetchPlaylistDetails(playlist.identifier)
                }
              }
            }
            .padding()
          }

          if let selectedPlaylistId, !isLoading {
            if let details = viewModel.playlistDetails {
              VStack(alignment: .leading) {

                ScrollView {
                  VStack(alignment: .leading, spacing: 16) {
                    ForEach(details.track, id: \.title) { track in
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
                      .padding(.horizontal)
                      .padding(.vertical, 5)
                    }
                  }
                  .padding(.horizontal)
                }
              }
              .padding(.top)
            }
          } else {
            ProgressView("Loading...")
              .padding()
              .frame(maxWidth: .infinity,maxHeight: .infinity)
          }
        }
        .onAppear {
          viewModel.getCreatedForYou(username: userName)
          if let firstPlaylist = viewModel.createdForYou.first {
            fetchPlaylistDetails(firstPlaylist.identifier)
          }
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
      }
    }

    private func fetchPlaylistDetails(_ identifierURL: String) {
        if let playlistId = viewModel.extractPlaylistId(from: identifierURL) {
            selectedPlaylistId = identifierURL
            isLoading = true
            viewModel.getCreatedForYouPlaylist(playlistId: playlistId)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isLoading = false
            }
        } else {
            print("Failed to extract playlist ID from URL")
        }
    }
}


