import SwiftUI

struct SongDetailView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject private var imageLoader = ImageLoader.shared
    @State private var isLoading = true
    @Environment(\.colorScheme) var colorScheme

    var onPinTrack: (Listen) -> Void
    var onRecommendPersonally: (Listen) -> Void
    var onWriteReview: (Listen) -> Void

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.backgroundColor : Color.white

            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        ForEach(homeViewModel.listens, id: \.recordingMsid) { listen in
                            TrackInfoView(
                                item: listen,
                                onPinTrack: { event in
                                    onPinTrack(listen)
                                },
                                onRecommendPersonally: { event in
                                    onRecommendPersonally(listen)
                                },
                                onWriteReview: { event in
                                    onWriteReview(listen)
                                }
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(colorScheme == .dark ? Color(.systemBackground).opacity(0.1) : Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                    }
//                    .refreshable {
//                        await loadListens()
//                    }
                }
            }
            .onAppear {
                loadListens()
            }
        }
    }

    private func loadListens() {
        isLoading = true
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


