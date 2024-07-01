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
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var selectedEvent: Event?
    @State private var isPresented:Bool = false

    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.backgroundColor : Color.white

            VStack {
                TopBar(isSettingsPressed: $isSettingsPressed, isSearchActive: $isSearchActive, customText: "Feed")

                ScrollView {
                    ForEach(viewModel.events, id: \.id) { event in
                        HStack(alignment: .top, spacing: 10) {
                            VStack(alignment: .leading) {
                                EventImageView(eventType: event.eventType)
                                    .frame(width: 22, height: 22)
                                VerticalLine(color: colorScheme == .dark ? Color.white : Color.black)
                                    .frame(width: 1, height: event.eventType == "follow" ? 15 : 60)
                                    .offset(x: 10, y: 4)
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                EventDescriptionView(event: event)
                                if event.eventType != "follow" {
                                    TrackInfoView(item: event, onPinTrack: { event in
                                        selectedEvent = event
                                        showPinTrackView = true
                                    }, onRecommendPersonally: { event in
                                        selectedEvent = event
                                        showingRecommendToUsersPersonallyView = true
                                    })
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(colorScheme == .dark ? Color.black : Color.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 2)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                }
                .sheet(isPresented: $isSettingsPressed) {
                    SettingsView()
                }
            }
            .ignoresSafeArea(.keyboard)
            .centeredModal(isPresented: $showPinTrackView) {
                if let event = selectedEvent {
                    PinTrackView(
                      isPresented: $isPresented, item: event,
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




