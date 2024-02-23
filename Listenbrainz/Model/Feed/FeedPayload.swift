//
//  FeedPayload.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


// MARK: - FeedPayload
struct FeedPayload: Codable {
  let events: [Event]

  enum CodingKeys: String, CodingKey {
      case events
  }
}
