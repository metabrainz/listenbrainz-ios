import SwiftUI

struct SongDetailView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject private var imageLoader = ImageLoader.shared
    @State private var isLoading = true
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.backgroundColor : Color.white

            VStack {
                ScrollView {
                    ForEach(homeViewModel.listens, id: \.recordingMsid) { listen in
                        TrackInfoView(item: listen)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(colorScheme == .dark ? Color.black : Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
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
}
