//
//  EventDescriptionView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//

import SwiftUI

struct EventDescriptionView: View {
    @EnvironmentObject var theme: Theme
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    let event: Event
    
    var attributedString: AttributedString {
        AttributedString(
            convertLinkToAttributedString(
                text: event.metadata.message ?? "",
                linkColor: theme.colorScheme.lbSignature
            )
        )
    }

    var body: some View {
        Group {
            if event.eventType == "notification" {
                Text(attributedString)
                    .font(.subheadline)
                    .foregroundColor(theme.colorScheme.text)
            } else {
                eventDescription(for: event)
                    .font(.subheadline)
                    .foregroundColor(theme.colorScheme.text)
            }
        }
    }

    private func eventDescription(for event: Event) -> Text {
        let usernameText = Text(replaceUsernameIfNeeded(event.userName))
            .foregroundColor(theme.colorScheme.lbSignature)


        switch event.eventType {
        case "listen":
            return usernameText
                + Text(" listened to a track ")
                .foregroundColor(theme.colorScheme.text)

        case "recording_recommendation":
            return usernameText
                + Text(" recommended a track ")
                .foregroundColor(theme.colorScheme.text)

        case "critiquebrainz_review":
            return usernameText
                + Text(" reviewed a track ")
                .foregroundColor(theme.colorScheme.text)

        case "recording_pin":
            return usernameText
                + Text(" pinned a track ")
                .foregroundColor(theme.colorScheme.text)

        case "follow":
            let username0Text = Text(replaceUsernameIfNeeded(event.metadata.userName0 ?? ""))
                .foregroundColor(theme.colorScheme.lbSignature)
            let username1Text = Text(replaceUsernameIfNeeded(event.metadata.userName1 ?? ""))
                .foregroundColor(theme.colorScheme.lbSignature)

            return username0Text
                + Text(" started following ")
                .foregroundColor(theme.colorScheme.text)
                + username1Text

        default:
            return Text("An event occurred")
                .foregroundColor(theme.colorScheme.text)
        }
    }

    private func replaceUsernameIfNeeded(_ username: String) -> String {
        return username == userName ? "You" : username
    }
}





