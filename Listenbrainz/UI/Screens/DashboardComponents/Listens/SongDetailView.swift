import SwiftUI

struct SongDetailView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject private var imageLoader = ImageLoader.shared
    @State private var isLoading = true
    @EnvironmentObject var theme: Theme

    var onPinTrack: (Listen) -> Void
    var onRecommendPersonally: (Listen) -> Void
    var onWriteReview: (Listen) -> Void

    var body: some View {
        ZStack {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // For when shadow cuts off for first ever item.
                    Spacer(minLength: theme.sizes.shadowRadius)
                    
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
                        .background(theme.colorScheme.level1)
                        .cornerRadius(10)
                        .shadow(radius: theme.sizes.shadowRadius)
                        .padding(.horizontal, theme.spacings.horizontal)
                    }
                    
                    // For when shadow cuts off for last ever item.
                    Spacer(minLength: theme.sizes.shadowRadius)
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


