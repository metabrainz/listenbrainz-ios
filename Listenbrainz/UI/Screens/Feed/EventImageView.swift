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
        var backgroundColor: Color

        switch eventType {
        case "listen":
          backgroundColor = Color.secondary
        case "recording_recommendation":
            backgroundColor = .blue
        case "critiquebrainz_review":
            backgroundColor = .green
        case "recording_pin":
            backgroundColor = .orange
        case "follow":
            backgroundColor = .green
        case "notification":
            backgroundColor = .blue
        default:
            backgroundColor = .cyan
        }

        return Image(systemName: symbolName)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(20)
            .clipShape(Circle())
    }

    private var symbolName: String {
        switch eventType {
        case "listen":
            return "headphones.circle"
        case "recording_recommendation":
            return "paperplane.circle"
        case "critiquebrainz_review":
            return "eye"
        case "recording_pin":
            return "pin.circle"
        case "follow":
            return "person.fill.badge.plus"
        case "notification":
            return "bell.circle"
        default:
            return "beats.headphones"
        }
    }
}
