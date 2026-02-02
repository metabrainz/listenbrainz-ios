//
//  FeedView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//


import SwiftUI

struct FeedView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @EnvironmentObject var insetsHolder: InsetsHolder
    @EnvironmentObject var theme: Theme
    @State private var isSettingsPressed = false
    @State private var isSearchActive = false
    @Environment(\.colorScheme) var colorScheme
    @State private var showPinTrackView = false
    @State private var showWriteReview = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var selectedEvent: Event?
    @State private var isPresented: Bool = false
    @State private var topBarSize: CGSize = .zero
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width * 0.9
    }
    
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            theme.colorScheme.background
            
            TopBar(
                isSettingsPressed: $isSettingsPressed,
                isSearchActive: $isSearchActive,
                customText: "Feed"
            )
            .backgroundBlur()
            .zIndex(1)
            .readSize($topBarSize)
            
            VStack {
                Color.clear.frame(height: topBarSize.height)
                Picker("Feed Type", selection: $viewModel.feedType) {
                    Text("My Feed").tag(FeedType.events)
                    Text("Following").tag(FeedType.following)
                    Text("Similar").tag(FeedType.similar)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.bottom, 10)
                .onChange(of: viewModel.feedType) { newType in
                    Task {
                        viewModel.changeFeedType(to: newType)
                        try? await viewModel.fetchFeedEvents(username: userName, userToken: userToken)
                    }
                }
                if viewModel.isLoading && viewModel.isInitialLoad {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: theme.spacings.vertical) {
                            ForEach(viewModel.events, id: \.created) { event in
                                buildFeedItem(event: event)
                            }
                            if viewModel.canLoadMorePages {
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .onAppear {
                                            Task {
                                                try? await viewModel.fetchFeedEvents(username: userName, userToken: userToken)
                                            }
                                        }
                                    Spacer()
                                }
                                .padding(.vertical, 20)
                            } else if !viewModel.events.isEmpty {
                                Text("✓ You are all caught up!")
                                    .font(.body)
                                    .foregroundColor(.blue)
                                    .padding(.top, 10)
                            } else {
                                Text("No events found")
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .padding(.top, 10)
                            }
                        }
                        .padding(.horizontal, theme.spacings.horizontal)
                        
                        Spacer(minLength: theme.spacings.screenBottom)
                    }
                    .padding(.bottom, insetsHolder.tabBarHeight)
                    .refreshable {
                        await refreshFeed()
                    }
                }
            }
            .sheet(isPresented: $isSettingsPressed) {
                SettingsView()
            }
            .centeredModal(isPresented: $showPinTrackView) {
                if let event = selectedEvent {
                    PinTrackView(isPresented: $isPresented, item: event, userToken: userToken, dismissAction: { showPinTrackView = false })
                        .environmentObject(viewModel)
                }
            }
            .centeredModal(isPresented: $showingRecommendToUsersPersonallyView) {
                if let event = selectedEvent {
                    RecommendToUsersPersonallyView(item: event, userName: userName, userToken: userToken, dismissAction: { showingRecommendToUsersPersonallyView = false })
                        .environmentObject(viewModel)
                }
            }
            .centeredModal(isPresented: $showWriteReview) {
                if let event = selectedEvent {
                    WriteAReviewView(isPresented: $showWriteReview, item: event, userToken: userToken, userName: userName, dismissAction: { showWriteReview = false })
                        .environmentObject(viewModel)
                }
            }
        }
    }
    @ViewBuilder
    private func buildFeedItem(event: Event) -> some View {
        BaseFeedView(
            icon: {
                EventImageView(eventType: event.eventType)
                    .frame(width: 22, height: 22)
            },
            title: {
                EventDescriptionView(event: event)
            },
            content: {
                VStack {
                    if event.eventType != "follow" && event.eventType != "notification" {
                        ListenCardView(
                            item: event, onPinTrack: { event in
                                selectedEvent = event
                                showPinTrackView = true
                            }, onRecommendPersonally: { event in
                                selectedEvent = event
                                showingRecommendToUsersPersonallyView = true
                            }, onWriteReview: { event in
                                selectedEvent = event
                                showWriteReview = true
                            }
                        )
                        .padding(.horizontal, theme.sizes.shadowRadius)
                        
                        if event.eventType == "critiquebrainz_review" {
                            ReviewView(event: event)
                                .frame(width: screenWidth, alignment: .leading)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text(formatFeedTime(Int64(event.created)))
                            .font(.system(size: 10))
                            .foregroundColor(theme.colorScheme.hint)
                            .italic()
                            .padding(.trailing, 4)
                        
                        if event.eventType == "recording_recommendation" || event.eventType == "pin" {
                            Button(action: {
                                viewModel.deleteEvent(
                                    userName: userName,
                                    eventID: event.id ?? 1,
                                    eventType: event.eventType,
                                    userToken: userToken
                                )
                            }) {
                                Image("feed_delete")
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(theme.colorScheme.lbSignature)
                            }
                        }
                    }
                }
            },
            lineColor: theme.colorScheme.hint,
            spacing: theme.spacings.horizontal
        )
        .frame(maxWidth: .infinity)
    }
    
    private func refreshFeed() async {
        do {
            viewModel.resetPagination()
            try await viewModel.fetchFeedEvents(username: userName, userToken: userToken)
        } catch {
            print("Error refreshing feed: \(error)")
        }
    }

    // MARK: - Time Helper
    // This function ensures format is "11:50 PM"
    private func formatFeedTime(_ epoch: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(epoch))
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short // This gives "11:50 PM" based on locale
        return formatter.string(from: date)
    }
}


struct VerticalLine: View {
    var color: Color
    var body: some View {
        Rectangle()
            .fill(color)
            .cornerRadius(0.75)
            .frame(width: 1.5)
    }
}


struct ReviewView: View {
    let event: Event
    @EnvironmentObject var theme: Theme
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("Rating:")
                    .fontWeight(.bold)
                ForEach(0..<5) { index in
                    Image(systemName: index < (event.metadata.rating ?? 0) ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
            Text(event.metadata.text ?? "")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .italic()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(theme.colorScheme.level1)
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
        .padding(.top, 5)
    }
}
