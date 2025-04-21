//
//  ListenbrainzApp.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 19/03/23.
//

import SwiftUI
import SpotifyiOS

@main
struct ListenbrainzApp: App {
    @StateObject var homeViewModel =  HomeViewModel(repository: HomeRepositoryImpl())
    @StateObject var feedViewModel = FeedViewModel(repository: FeedRepositoryImpl())
    @StateObject var dashboardViewModel = DashboardViewModel(repository: DashboardRepositoryImpl())
    @StateObject var theme = Theme()
    
    @AppStorage(Strings.AppStorageKeys.isOnboarding) var isOnboarding: Bool = true
    //@StateObject var spotifyManager = SpotifyManager()
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isOnboarding {
                    OnBoardingView()
                        .environmentObject(theme)
                }
                else{
                    ContentView()
                        .environmentObject(homeViewModel)
                        .environmentObject(feedViewModel)
                        .environmentObject(dashboardViewModel)
                        .environmentObject(theme)
                        .preferredColorScheme(theme.systemColorScheme)
                        .onOpenURL { url in
                            //spotifyManager.sessionManager.application(UIApplication.shared, open: url, options: [:])
                        }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
    
    private func handleSpotifySession() {
        //spotifyManager.connect()
    }
}
