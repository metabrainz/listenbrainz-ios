//
//  ContentView.swift
//  Listenbrainz
//
//  Created by avataar on 19/03/23.
//

import SwiftUI

struct ListensView: View {
    @EnvironmentObject var spotifyManager: SpotifyManager
    @State private var spotifyID: String = "https://open.spotify.com/track/0DHh3p0g7qmNNfNdRNwL6N"

    var body: some View {
        VStack {
           TextField("Enter Spotify ID", text: $spotifyID)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()

           Button(action: {
               spotifyManager.playSong(spotifyID: spotifyID)
           }) {
               Text("Play Song")
                   .font(.headline)
                   .padding()
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(10)
           }
       }
        .padding()
    }
}

struct ListensView_Previews: PreviewProvider {
    static var previews: some View {
        ListensView()
            .environmentObject(SpotifyManager())
    }
}
