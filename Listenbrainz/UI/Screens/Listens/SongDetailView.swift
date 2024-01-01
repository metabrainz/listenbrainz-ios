import SwiftUI

struct SongDetailView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject private var imageLoader = ImageLoader.shared
    @State private var isLoading = true

    var body: some View {
        VStack {
            List {
                ForEach(homeViewModel.listens, id: \.recordingMsid) { listen in
                    HStack {
                      if let coverArtURL = listen.trackMetadata?.coverArtURL {
                            AsyncImage(
                                url: coverArtURL,
                                scale: 0.1,
                                transaction: Transaction(animation: nil),
                                content: { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .onAppear {
                                                imageLoader.loadImage(url: coverArtURL) { loadedImage in
                                                    if let uiImage = loadedImage {
                                                        ImageCache.shared.insertImage(uiImage, for: coverArtURL)
                                                    }
                                                }
                                            }

                                    default:
                                        if let cachedImage = ImageCache.shared.image(for: coverArtURL) {
                                            Image(uiImage: cachedImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                        } else {
                                            Image(systemName: "music.note")
                                                .resizable()
                                                .renderingMode(.template)
                                                .foregroundColor(.orange)
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                }
                            )
                            .frame(width: 50, height: 50)
                        } else {
                            Image(systemName: "music.note")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.orange)
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }

                        VStack(alignment: .leading) {
                          Text(listen.trackMetadata!.trackName)
                                .lineLimit(1)
                                .font(.headline)
                          Text(listen.trackMetadata!.artistName)
                                .lineLimit(1)
                        }
                    }
                }
                .navigationTitle("Listens")
            }
            .listStyle(PlainListStyle())
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 16))
        }
        .onAppear {
            Task {
                await withTaskGroup(of: Void.self) { group in
                    for listen in homeViewModel.listens {
                      if let coverArtURL = listen.trackMetadata?.coverArtURL {
                            group.addTask {
                                await imageLoader.loadImage(url: coverArtURL) { _ in }
                            }
                        }
                    }
                    await group.waitForAll()
                }
                isLoading = false
            }
        }
    }
}


