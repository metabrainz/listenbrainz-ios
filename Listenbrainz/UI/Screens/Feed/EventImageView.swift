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
    let imageName: String

    switch eventType {
    case "listen":
      imageName = "beats.headphones"
    case "recording_recommendation":
      imageName = "star"
    case "critiquebrainz_review":
      imageName = "eye"
    case "recording_pin":
      imageName = "pin"
    case "follow":
      imageName = "person.fill"
    default:
      imageName = "headphones.circle"
    }

    return Image(systemName: imageName)
      .resizable()
      .scaledToFit()
      .frame(width: 22, height: 22)
      .foregroundColor(.white)
      .background(Color.secondary)
      .cornerRadius(20)
      .clipShape(Circle())
  }
}
