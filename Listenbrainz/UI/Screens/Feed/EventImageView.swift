//
//  EventImageView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//


import SwiftUI

struct EventImageView: View {
    let eventType: String

    var body: some View {
        return Image(symbolName)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var symbolName: String {
        switch eventType {
        case "listen":
            return "feed_listen"
        case "recording_recommendation":
            return "feed_send"
        case "personal_recording_recommendation":
            return "feed_send"
        case "critiquebrainz_review":
            return "feed_review"
        case "recording_pin":
            return "feed_pin"
        case "like":
            return "feed_love"
        case "follow":
            return "feed_follow"
        case "notification":
            return "feed_notification"
        default:
            return "feed_unknown"
        }
    }
}
