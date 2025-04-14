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
            .background(.ultraThinMaterial)
            .zIndex(1)
            .readSize($topBarSize)

            VStack {
                if viewModel.isLoading && viewModel.isInitialLoad {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack {
                            Spacer(minLength: topBarSize.height + theme.spacings.vertical)
                            
                            ForEach(viewModel.events, id: \.created) { event in
                                HStack(alignment: .top, spacing: 10) {
                                    VStack(alignment: .leading) {
                                        EventImageView(eventType: event.eventType)
                                            .frame(width: 22, height: 22)
                                        VerticalLine(color: theme.colorScheme.text)
                                            .frame(width: 1, height: verticalLineHeight(for: event))
                                            .offset(x: 10, y: 4)
                                    }

                                    VStack(alignment: .leading, spacing: 5) {
                                        EventDescriptionView(event: event)
                                        
                                        if event.eventType != "follow" && event.eventType != "notification" {
                                          Spacer(minLength: 8)
                                            
                                          TrackInfoView(item: event, onPinTrack: { event in
                                            selectedEvent = event
                                            showPinTrackView = true
                                          }, onRecommendPersonally: { event in
                                            selectedEvent = event
                                            showingRecommendToUsersPersonallyView = true
                                          }, onWriteReview: { event in
                                            selectedEvent = event
                                            showWriteReview = true
                                          })
                                          .background(theme.colorScheme.level1)
                                          .cornerRadius(theme.sizes.cornerRadius)
                                          .shadow(radius: theme.sizes.shadowRadius)
                                          .padding(.horizontal, theme.sizes.shadowRadius)

                                          if event.eventType == "critiquebrainz_review" {
                                            ReviewView(event: event)
                                              .frame(width: screenWidth, alignment: .leading)
                                          }
                                        }

                                        HStack {
                                          Spacer()

                                          Text(formatDate(epochTime: TimeInterval(event.created)))
                                            .font(.system(size: 10))
                                            .foregroundColor(theme.colorScheme.hint)
                                            .italic()
                                            .padding(.trailing,4)

                                          if event.eventType == "recording_recommendation" {
                                            Button(action: {
                                              viewModel.deleteEvent(userName: userName, eventID: event.id ?? 1, userToken: userToken)
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
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 4)
                                .onAppear {
                                    if event == viewModel.events.last && viewModel.canLoadMorePages {
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            Task {
                                                do {
                                                    try await viewModel.fetchFeedEvents(username: userName, userToken: userToken)
                                                } catch {
                                                    print("Error fetching more events: \(error)")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, theme.spacings.horizontal)
                        if viewModel.isLoading {
                          ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.vertical, 10)
                        }
                        
                        Spacer(minLength: theme.spacings.screenBottom)
                    }
                    .padding(.bottom, insetsHolder.tabBarHeight)
                    .sheet(isPresented: $isSettingsPressed) {
                        SettingsView()
                    }
                    .onAppear{
                      Task {
                        do {
                          try await viewModel.fetchFeedEvents(username: userName, userToken: userToken)
                        } catch {
                          print("Error: \(error)")
                        }
                      }
                    }
                    .refreshable {
                        await refreshFeed()
                    }
                }
            }
            .centeredModal(isPresented: $showPinTrackView) {
                if let event = selectedEvent {
                    PinTrackView(
                        isPresented: $isPresented,
                        item: event,
                        userToken: userToken,
                        dismissAction: {
                            showPinTrackView = false
                        }
                    )
                    .environmentObject(viewModel)
                }
            }
            .centeredModal(isPresented: $showingRecommendToUsersPersonallyView) {
                if let event = selectedEvent {
                    RecommendToUsersPersonallyView(item: event, userName: userName, userToken: userToken, dismissAction: {
                        showingRecommendToUsersPersonallyView = false
                    })
                    .environmentObject(viewModel)
                }
            }
            .centeredModal(isPresented: $showWriteReview) {
                if let event = selectedEvent {
                    WriteAReviewView(isPresented: $showWriteReview, item: event, userToken: userToken, userName: userName) {
                        showWriteReview = false
                    }
                    .environmentObject(viewModel)
                }
            }
        }
    }

    // TODO: Make heights not depend on event but layout bounds
    private func verticalLineHeight(for event: Event) -> CGFloat {
        switch event.eventType {
        case "critiquebrainz_review":
            return 160
        case "notification":
          return 15
        case "follow":
          return 15
        default:
            return 80
        }
    }

    private func refreshFeed() async {
        do {
            viewModel.resetPagination()
            try await viewModel.fetchFeedEvents(username: userName, userToken: userToken)
        } catch {
            print("Error refreshing feed: \(error)")
        }
    }
}


struct VerticalLine: View {
  var color: Color
  var body: some View {
    Rectangle()
      .fill(color)
      .frame(width: 1)
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
