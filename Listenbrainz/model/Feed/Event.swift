//
//  Event.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation


// MARK: - Event
struct Event: Codable, Identifiable {
  let created: Int
  let eventType: String
  let hidden: Bool
  let metadata: Metadata
  let userName: String
  var id: Int {
    created
  }

  enum CodingKeys: String, CodingKey {
      case created
      case eventType = "event_type"
      case hidden, metadata
      case userName = "user_name"
  }
}


