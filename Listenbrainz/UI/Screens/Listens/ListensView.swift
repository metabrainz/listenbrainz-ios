//
//  ContentView.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 19/03/23.
//

import SwiftUI

struct ListensView: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  @StateObject private var dashboardViewModel = DashboardViewModel(repository: DashboardRepositoryImpl())
  @State private var spotifyID: String = "https://open.spotify.com/track/0DHh3p0g7qmNNfNdRNwL6N"
  @State private var maxTimeStamp: String = "john"
  @State private var minTimeStamp: String = "123456"
  @State private var isSettingsPressed = false
  @State private var isSearchActive = false
  @Environment(\.colorScheme) var colorScheme
  @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

  var params: [String: String] {
    return ["max_ts": maxTimeStamp, "min_ts": minTimeStamp]
  }

  var body: some View {
    ZStack {
      colorScheme == .dark ? Color.backgroundColor : Color.white

      VStack {
        TopBar(isSettingsPressed: $isSettingsPressed, isSearchActive: $isSearchActive, customText: "Listens")

        ScrollView{

          ListensStatsView(dashboardViewModel: dashboardViewModel)

          SongDetailView()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .onAppear {
              homeViewModel.requestMusicData(userName: userName)
              dashboardViewModel.userName = userName
            }
            .sheet(isPresented: $isSettingsPressed) {
              SettingsView()
            }
        }
      }
    }
  }
}


struct ListensStatsView: View {
    @ObservedObject var dashboardViewModel: DashboardViewModel
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
        VStack {
            Text("You have listened to")
                .font(.headline)
            Text("\(dashboardViewModel.listenCount)")
                .font(.largeTitle)
                .bold()
            Text("songs so far")
                .font(.subheadline)

            Divider()

            HStack {
                NavigationLink(destination: FollowersView(dashboardViewModel: dashboardViewModel)) {
                    VStack {
                        Text("\(dashboardViewModel.followers.count)")
                            .font(.title)
                            .bold()
                        Text("Followers")
                            .font(.subheadline)
                    }
                }

                NavigationLink(destination: FollowingView(dashboardViewModel: dashboardViewModel)) {
                    VStack {
                        Text("\(dashboardViewModel.following.count)")
                            .font(.title)
                            .bold()
                        Text("Following")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .onAppear {
            dashboardViewModel.getListenCount(username: userName)
            dashboardViewModel.getFollowers(username: userName)
            dashboardViewModel.getFollowing(username: userName)
        }
    }
}



struct FollowersView: View {
    @ObservedObject var dashboardViewModel: DashboardViewModel

    var body: some View {
        VStack {
            Text("Followers")
                .font(.largeTitle)
                .bold()
            List(dashboardViewModel.followers, id: \.self) { follower in
                Text(follower)
            }
        }
        .onAppear {
            dashboardViewModel.getFollowers(username: dashboardViewModel.userName)
        }
    }
}

struct FollowingView: View {
    @ObservedObject var dashboardViewModel: DashboardViewModel

    var body: some View {
        VStack {
            Text("Following")
                .font(.largeTitle)
                .bold()
            List(dashboardViewModel.following, id: \.self) { following in
                Text(following)
            }
        }
        .onAppear {
            dashboardViewModel.getFollowing(username: dashboardViewModel.userName)
        }
    }
}




