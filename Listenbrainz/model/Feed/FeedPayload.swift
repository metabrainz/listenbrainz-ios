//
//  FeedPayload.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


// MARK: - FeedPayload
struct FeedPayload: Codable {
  let count: Int
  let events: [Event]
  let userID: User

  enum CodingKeys: String, CodingKey {
      case count, events
      case userID = "user_id"
  }
}
