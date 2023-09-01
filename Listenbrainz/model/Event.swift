//
//  Event.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation


// MARK: - Event
struct Event: Codable {
    let created: Int
    let eventType: String
    let hidden: Bool
    let id: Int?
    let metadata: Metadata
    let userName: User

    enum CodingKeys: String, CodingKey {
        case created
        case eventType = "event_type"
        case hidden, id, metadata
        case userName = "user_name"
    }
}
