//
//  PlayerView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//


import SwiftUI
import ShazamKit

extension SHMatchedMediaItem: Identifiable {

    public var id: String {
        shazamID ?? ""
    }
}

struct PlayerView: View {

    @StateObject private var viewModel: ShazamViewModel = .init()

    var body: some View {
        content
            .sheet(item: $viewModel.mediaItem) { mediaItem in
                MediaItemView(mediaItem: mediaItem)
            }
            .alert(isPresented: $viewModel.hasError) {
                Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? ""))
            }
    }

    @ViewBuilder
  var content: some View {
    if viewModel.matching {
      ProgressView("Listening...")
        .tint(Color.color_1)
        .foregroundColor(Color.color_2)
    }
    else {
      VStack(spacing:40) {
        Image(systemName: "shazam.logo.fill")
          .resizable()
          .frame(width: 150, height: 150)
          .foregroundColor(Color.color_2)
        Button(action: shazam) {
          Text("Shazam")
            .padding()
            .foregroundColor(.white)
            .background(Color.color_1)
            .cornerRadius(10)
        }
        Button(viewModel.isMatching ? "Matching…" : "Match Custom audio", action: viewModel.startMatching)
                 .disabled(viewModel.isMatching)
                 .tint(.blue)
                 .padding(.vertical)
                 .buttonStyle(.borderless)
                 .offset(y:90)
      }
    }
  }
    func shazam() {
        viewModel.start()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
