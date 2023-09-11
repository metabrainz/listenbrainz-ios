//
//  MediaItemView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/07/23.
//

import SwiftUI
import ShazamKit

struct MediaItemView: View {

    @State var mediaItem: SHMatchedMediaItem

    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                image(with: proxy)
                infoView
                Spacer()
            }
        }
        .padding()
    }

    @ViewBuilder
    private var infoView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(mediaItem.title ?? "Unknown track")
                .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text(mediaItem.artist ?? "Unknown artist")
                    .font(.body)
                    .foregroundColor(Color.white)
            }
            Spacer()
        }
    }

    @ViewBuilder
    private func image(with proxy: GeometryProxy) -> some View {
        AsyncImage(url: mediaItem.artworkURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image(systemName: "photo")
                .imageScale(.large)
                .frame(width: proxy.size.width,
                       height: proxy.size.width,
                       alignment: .center)
                .background(Color(UIColor.secondarySystemBackground))

        }
        .cornerRadius(10)
    }

    private func add() {
        SHMediaLibrary.default.add([mediaItem]) { error in
            print(error ?? "Added successfully")
        }
    }
}
