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

    @StateObject var spotifyManager = SpotifyManager()
  @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
          let feedViewModel = FeedViewModel()
          ContentView()
            .environmentObject(homeViewModel)
            .environmentObject(feedViewModel)
            .preferredColorScheme(isDarkMode ? .dark : .light)
                .environmentObject(spotifyManager)
                .onAppear(perform: handleSpotifySession)
                .onOpenURL { url in
                    spotifyManager.sessionManager.application(UIApplication.shared, open: url, options: [:])

                }
        }
    }
    
    private func handleSpotifySession() {
        if spotifyManager.isSessionValid() {
            spotifyManager.connect()
        }
        else {
            let scope: SPTScope = [.appRemoteControl, .userLibraryRead, .playlistReadPrivate, .userLibraryModify]
            spotifyManager.sessionManager.initiateSession(with: scope, options: .default)
        }
    }

}
