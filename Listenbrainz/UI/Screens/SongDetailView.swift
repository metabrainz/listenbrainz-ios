//
//  SongDetailView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import SwiftUI

struct SongDetailView: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  @State private var userNameInput: String = ""
  @State private var listensFetched: Bool = false

  var body: some View {
    VStack {
      if !listensFetched {
        TextField("Enter Username", text: $userNameInput)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .frame(height: 10)
          .padding()


        Button(action: {
          homeViewModel.requestMusicData(userName: userNameInput)
          listensFetched = true
        }) {
          Text("Fetch Listens")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.color_1)
            .cornerRadius(10)
            .frame(height:10)
        }
        .padding()
      }

      else{
        Button {
          listensFetched = false
        } label: {
          Text("Enter again")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.color_1)
            .cornerRadius(10)
            
        }
        .offset(x: 100 , y:5)
      }


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
                  .foregroundColor(.secondary)
              }
            }
          }
        }

        .navigationTitle("Songs")

      }
    }
  }


struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView()
    }
}

