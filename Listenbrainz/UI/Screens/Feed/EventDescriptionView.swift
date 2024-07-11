//
//  EventDescriptionView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//

import SwiftUI

struct EventDescriptionView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    let event: Event

    var body: some View {
        Group {
            if event.eventType == "notification" {
                TextViewRepresentable(text: event.metadata.message ?? "", linkColor: .blue, foregroundColor: foregroundColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(foregroundColor)
            } else {
                eventDescription(for: event)
                    .font(.subheadline)
                    .foregroundColor(foregroundColor)
            }
        }
    }

    private var foregroundColor: Color {
        return colorScheme == .dark ? .white : .black
    }

    private func eventDescription(for event: Event) -> Text {
        let usernameText = Text(replaceUsernameIfNeeded(event.userName))
            .foregroundColor(Color.LbPurple)

        switch event.eventType {
        case "listen":
            return usernameText
                + Text(" listened to a track ")
                .foregroundColor(foregroundColor)

        case "recording_recommendation":
            return usernameText
                + Text(" recommended a track ")
                .foregroundColor(foregroundColor)

        case "critiquebrainz_review":
            return usernameText
                + Text(" reviewed a track ")
                .foregroundColor(foregroundColor)

        case "recording_pin":
            return usernameText
                + Text(" pinned a track ")
                .foregroundColor(foregroundColor)

        case "follow":
            let username0Text = Text(replaceUsernameIfNeeded(event.metadata.userName0 ?? ""))
                .foregroundColor(Color.LbPurple)
            let username1Text = Text(replaceUsernameIfNeeded(event.metadata.userName1 ?? ""))
                .foregroundColor(Color.LbPurple)

            return username0Text
                + Text(" started following ")
                .foregroundColor(foregroundColor)
                + username1Text

        default:
            return Text("An event occurred")
                .foregroundColor(foregroundColor)
        }
    }

    private func replaceUsernameIfNeeded(_ username: String) -> String {
        return username == userName ? "You" : username
    }
}





