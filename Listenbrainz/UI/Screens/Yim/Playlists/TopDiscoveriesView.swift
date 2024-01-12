//
//  TopDiscoveriesView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import SwiftUI

struct TopDiscoveriesView: View {
    @ObservedObject var viewModel: YIMViewModel

    @State private var isShowingList = false

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: UIScreen.main.bounds.height)
                .background(Color.yimGreen)

            VStack {
              Spacer()
                TopYimView(viewModel: viewModel)

              Spacer()
                ZStack {
                    Image("hug")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 330, height: 283)
                        .zIndex(2)

                    if !isShowingList {
                        VStack(spacing: 0) {
                            if let topDiscoveries = viewModel.topDiscoveries,
                               let playlist = topDiscoveries.playlist,
                               let trackElements = playlist.track {

                                ForEach(0..<3) { j in
                                    HStack(spacing: 0) {
                                        ForEach(0..<3) { i in
                                            if let track = trackElements[safe: (j * 3) + i],
                                               let trackExtension = track.trackExtension,
                                               let httpsMusicbrainzOrgDocJspfTrack = trackExtension.httpsMusicbrainzOrgDocJspfTrack,
                                               let additionalMetadata = httpsMusicbrainzOrgDocJspfTrack.additionalMetadata,
                                               let caaID = additionalMetadata.caaID,
                                               let caaReleaseMbid = additionalMetadata.caaReleaseMbid,
                                               let coverArtURL = makeCoverArtURL(caaReleaseMbid: caaReleaseMbid, caaID: caaID) {

                                                CoverArtView(url: coverArtURL)
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 80, height: 80)
                                            } else {
                                                Image(systemName: "photo.fill")
                                                    .resizable()
                                                    .frame(width: 80, height: 80)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Image("plus")
                    .resizable()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .background(Circle().foregroundColor(.white))
                    .padding(.top, -50)
                    .onTapGesture {
                        withAnimation {
                            isShowingList.toggle()
                        }
                    }

                Spacer()
                Text("top discoveries of 2023".uppercased())
                .font(.system(size: 25, weight: .bold))
                .tracking(14)
                    .foregroundColor(Color(red: 0.15, green: 0.19, blue: 0.15))
                    .padding(.leading, 40)

                Spacer()

                Image("share")
                    .frame(width: 49, height: 49)
                    .padding(.trailing, 250)
                    .padding(.bottom, 40)

                BottomYimView()
                    .padding(.bottom, 30)
                    .onAppear {
                        viewModel.fetchYIMData(userName: "theflash_")
                    }
            }

            if isShowingList {
              GeometryReader { geometry in
                  AlbumListView(viewModel: viewModel, isShowingList: $isShowingList)
                  .frame(width: min(geometry.size.width / 1.5, 300), height: min(geometry.size.height / 1.5, 300))
                      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                      .transition(.move(edge: .bottom))
              }

            }
        }
    }




    private func makeCoverArtURL(caaReleaseMbid: String, caaID: Int) -> URL? {
        // Ensure both caaReleaseMbid and caaID are non-nil
        guard !caaReleaseMbid.isEmpty, caaID > 0 else {
            return nil
        }

        return URL(string: "https://coverartarchive.org/release/\(caaReleaseMbid)/\(caaID)-250.jpg")
    }
}




struct TopDiscoveriesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = YIMViewModel(repository: YIMRepositoryImpl())
        TopDiscoveriesView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}

struct AlbumListView: View {
    @ObservedObject var viewModel: YIMViewModel
    @Binding var isShowingList: Bool

    var body: some View {
        NavigationView {
          ScrollView {
            LazyVStack {
              ForEach(viewModel.topDiscoveries?.playlist?.track ?? [], id: \.identifier) { track in
                HStack {


                  VStack() {

                    Text(track.album)
                    Text(track.creator)
                  }
                  .padding()
                }
              }
            }
          }
            .listStyle(PlainListStyle())
            .listRowSeparator(.hidden)
            .navigationBarItems(trailing: Button(action: {
                withAnimation {
                    isShowingList.toggle()
                }
            }) {
                Image(systemName: isShowingList ? "arrow.down.right.and.arrow.up.left" : "list.dash")
            })
        }
    }
}

