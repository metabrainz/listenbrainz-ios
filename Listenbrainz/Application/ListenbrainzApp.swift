//
//  ListenbrainzApp.swift
//  Listenbrainz
//
//  Created by avataar on 19/03/23.
//

import SwiftUI
import SpotifyiOS

@main
struct ListenbrainzApp: App {
  @StateObject var homeViewModel =  HomeViewModel(repository: HomeRepositoryImpl())
  @StateObject var feedViewModel = FeedViewModel(repository: FeedRepositoryImpl())
  @AppStorage(Strings.AppStorageKeys.isOnboarding) var isOnboarding: Bool = true
  //@StateObject var spotifyManager = SpotifyManager()
  @AppStorage(Strings.AppStorageKeys.isDarkMode) private var isDarkMode = true
  @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
  @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

  var body: some Scene {
    WindowGroup {

      NavigationView {
        if isOnboarding {
          OnBoardingView()
        }
        else{
          ContentView()
            .environmentObject(homeViewModel)
            .environmentObject(feedViewModel)
            .preferredColorScheme(isDarkMode ? .dark : .light)
          //.environmentObject(spotifyManager)
            .onAppear {
              //handleSpotifySession()
              homeViewModel.requestMusicData(userName: userName)
              feedViewModel.fetchFeedEvents(username: userName, userToken: userToken)
            }
            .onOpenURL { url in
              //spotifyManager.sessionManager.application(UIApplication.shared, open: url, options: [:])
            }
        }
      }
    }
  }

  private func handleSpotifySession() {
    //spotifyManager.connect()
  }

}
