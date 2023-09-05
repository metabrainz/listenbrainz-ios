//
//  EventDescriptionView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/09/23.
//

import SwiftUI

struct EventDescriptionView: View {
  let event: Event

  var body: some View {
    Text(eventDescription(for: event))
      .font(.subheadline)
      .foregroundColor(.blue)
  }

  private func eventDescription(for event: Event) -> String {
    switch event.eventType {
    case "listen":
      return "\(event.userName) listened to a track"
    case "recording_recommendation":
      return "\(event.userName) recommended a track"
    case "critiquebrainz_review":
      return "\(event.userName) reviewed a track"
    case "recording_pin":
      return "\(event.userName) pinned a track"
    default:
      return "An event occurred"
    }
  }
}
