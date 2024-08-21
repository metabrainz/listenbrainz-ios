//
//  EventDescriptionView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//

import SwiftUI

struct EventDescriptionView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userSelection: UserSelection
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @AppStorage(Strings.AppStorageKeys.userName) private var currentUserName: String = ""
    @EnvironmentObject var homeViewModel: HomeViewModel

    let event: Event

    var body: some View {
        Group {
            if event.eventType == "notification" {
                TextViewRepresentable(text: event.metadata.message ?? "", linkColor: .blue, foregroundColor: foregroundColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(foregroundColor)
            } else {
                NavigationLink(destination: listensViewDestination(for: event)) {
                    HStack(spacing: 0) {
                        Text(replaceUsernameIfNeeded(event.userName))
                            .foregroundColor(Color.LbPurple)
                            .underline()

                        Text(eventDescriptionSuffix(for: event))
                            .foregroundColor(foregroundColor)
                    }
                }
                .buttonStyle(PlainButtonStyle())  // Ensures the link does not alter the HStack appearance
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    private var foregroundColor: Color {
        return colorScheme == .dark ? .white : .black
    }

    private func replaceUsernameIfNeeded(_ username: String) -> String {
        return username == currentUserName ? "You" : username
    }

    private func eventDescriptionSuffix(for event: Event) -> String {
        switch event.eventType {
        case "listen":
            return " listened to a track"
        case "recording_recommendation":
            return " recommended a track"
        case "critiquebrainz_review":
            return " reviewed a track"
        case "recording_pin":
            return " pinned a track"
        case "follow":
            return " started following"
        default:
            return "An event occurred"
        }
    }

    private func listensViewDestination(for event: Event) -> some View {
        ListensView()
            .environmentObject(homeViewModel)
            .environmentObject(dashboardViewModel)
            .environmentObject(userSelection)
            .onAppear {
                userSelection.selectUserName(event.userName)
            }
    }
}
