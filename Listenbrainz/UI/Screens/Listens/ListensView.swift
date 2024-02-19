//
//  ContentView.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 19/03/23.
//

import SwiftUI

struct ListensView: View {

  @EnvironmentObject var homeViewModel: HomeViewModel
  @EnvironmentObject var spotifyManager: SpotifyManager
  @State private var spotifyID: String = "https://open.spotify.com/track/0DHh3p0g7qmNNfNdRNwL6N"
  @State private var maxTimeStamp:String = "john"
  @State private var minTimeStamp:String = "123456"
  @State private var isSettingsPressed = false

  var params: [String: String] {
    return ["max_ts": maxTimeStamp, "min_ts":minTimeStamp]
  }

  var body: some View {
    VStack {

      TopBar(isSettingsPressed:$isSettingsPressed, customText: "Listens")

      SongDetailView()
        .environmentObject(homeViewModel)
        .sheet(isPresented: $isSettingsPressed) {
          SettingsView()
        }


      //           TextField("Enter Spotify ID", text: $spotifyID)
      //               .textFieldStyle(RoundedBorderTextFieldStyle())
      //               .padding()
      //
      //           Button(action: {
      //               spotifyManager.playSong(spotifyID: spotifyID)
      //           }) {
      //               Text("Play Song")
      //                   .font(.headline)
      //                   .padding()
      //                   .background(Color.blue)
      //                   .foregroundColor(.white)
      //                   .cornerRadius(10)
      //           }
    }

  }
}

