//
//  FeedView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//


import SwiftUI

struct FeedView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @State private var isSettingsPressed = false
    @State private var isSearchActive = false
    @Environment(\.colorScheme) var colorScheme
    @State private var showPinTrackView = false
    @State private var showWriteReview = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var selectedEvent: Event?
    @State private var isPresented: Bool = false

  private var screenWidth: CGFloat {
       UIScreen.main.bounds.width * 0.9
   }

    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.backgroundColor : Color.white

            VStack {
                TopBar(isSettingsPressed: $isSettingsPressed, isSearchActive: $isSearchActive, customText: "Feed")

                if viewModel.isLoading && viewModel.isInitialLoad {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.events, id: \.created) { event in
                                HStack(alignment: .top, spacing: 10) {
                                    VStack(alignment: .leading) {
                                        EventImageView(eventType: event.eventType)
                                            .frame(width: 22, height: 22)
                                        VerticalLine(color: colorScheme == .dark ? Color.white : Color.black)
                                            .frame(width: 1, height: verticalLineHeight(for: event))
                                            .offset(x: 10, y: 4)
                                    }

                                    VStack(alignment: .leading, spacing: 5) {
                                        EventDescriptionView(event: event)
                                      VStack(spacing:-5){
                                        if event.eventType != "follow" && event.eventType != "notification" {
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
                                          .frame(width: screenWidth, alignment: .leading)
                                          .background(colorScheme == .dark ? Color(.systemBackground).opacity(0.1) : Color.white)
                                          .cornerRadius(10)
                                          .shadow(radius: 2)

                                          if event.eventType == "critiquebrainz_review" {
                                            ReviewView(event: event)
                                              .frame(width: screenWidth, alignment: .leading)
                                          }
                                        }
                                      }

                                        HStack {
                                          Spacer()

                                          Text(formatDate(epochTime: TimeInterval(event.created)))
                                            .font(.system(size: 10))
                                            .foregroundColor(Color.gray)
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
                                                .foregroundColor(Color.LbPurple)
                                            }
                                          }
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
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
                        .padding([.trailing,.leading],6)
                      if viewModel.isLoading {
                        ProgressView()
                          .progressViewStyle(CircularProgressViewStyle())
                          .padding(.vertical, 10)
                      }
                    }
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

    private func verticalLineHeight(for event: Event) -> CGFloat {
        switch event.eventType {
        case "critiquebrainz_review":
            return 160
        case "notification":
          return 15
        case "follow":
          return 15
        default:
            return 60
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
        .background(colorScheme == .dark ? Color(.systemBackground).opacity(0.1) : Color.white)
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
        .padding(.top, 5)
    }
}







