//
//  EventDescriptionView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//

import SwiftUI


struct EventDescriptionView: View {
    @Environment(\.colorScheme) var colorScheme
    let event: Event

    var body: some View {
        eventDescription(for: event)
            .font(.subheadline)
            .foregroundColor(foregroundColor)
    }

    private var foregroundColor: Color {
        return colorScheme == .dark ? .white : .black
    }

    private func eventDescription(for event: Event) -> Text {
        let usernameText = Text(event.userName)
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
            let username0Text = Text(event.metadata.userName0 ?? "")
                .foregroundColor(Color.LbPurple)
            let username1Text = Text(event.metadata.userName1 ?? "")
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
}
