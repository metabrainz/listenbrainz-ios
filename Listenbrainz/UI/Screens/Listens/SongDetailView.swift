//
//  SongDetailView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import SwiftUI

struct SongDetailView: View {
  
  @EnvironmentObject var homeViewModel: HomeViewModel


  var body: some View {

    VStack {
      List {
        ForEach(homeViewModel.listens, id: \.recordingMsid) { listen in
          HStack {
            Image(systemName: "music.note")
              .resizable()
              .renderingMode(.template)
              .foregroundColor(.orange)
              .scaledToFit()
              .frame(height: 22)
              .padding(4)

            VStack(alignment: .leading) {
              Text(listen.trackMetadata.trackName)
                .lineLimit(1)
                .font(.headline)
              Text(listen.trackMetadata.artistName)
                .lineLimit(1)
                
            }
          }
        }


        .navigationTitle("Listens")


      }
    }
  }


}
