import SwiftUI

struct SongDetailView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject private var imageLoader = ImageLoader.shared
    @State private var isLoading = true
    @Environment(\.colorScheme) var colorScheme
    @State private var showPinTrackView = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var showWriteReview = false
    @State private var selectedListen: Listen?
    @State private var isPresented:Bool = false
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

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
                                    selectedListen = listen
                                    showPinTrackView = true
                                },
                                onRecommendPersonally: { event in
                                    selectedListen = listen
                                    showingRecommendToUsersPersonallyView = true
                                },
                                onWriteReview: { event in
                                    selectedListen = listen
                                    showWriteReview = true
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
            .centeredModal(isPresented: $showPinTrackView) {
                if let listen = selectedListen {
                    PinTrackView(
                        isPresented: $showPinTrackView,
                        item: listen,
                        userToken: userToken,
                        dismissAction: {
                            showPinTrackView = false
                        }
                    )
                    .environmentObject(homeViewModel)
                }
            }
            .centeredModal(isPresented: $showingRecommendToUsersPersonallyView) {
                if let listen = selectedListen {
                    RecommendToUsersPersonallyView(item: listen, userName: userName, userToken: userToken, dismissAction: {
                        showingRecommendToUsersPersonallyView = false
                    })
                    .environmentObject(homeViewModel)
                }
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

    private func refreshListens() async {
        isLoading = true
        do {
            try await homeViewModel.requestMusicData(userName: userName)
        } catch {
            print("Error refreshing listens: \(error)")
        }
        loadListens()
    }
}



