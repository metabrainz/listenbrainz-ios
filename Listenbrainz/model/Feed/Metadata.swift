//
//  Metadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation

// MARK: - Metadata
struct Metadata: Codable {
    let message: String?
    let insertedAt, listenedAt: Int?
    let listenedAtISO, playingNow: JSONNull?
    let trackMetadata: FeedTrackMetadata?
    let userName: String?
    let created: Int?
    let relationshipType: String?
    let userName0: String?
    let userName1, blurbContent: String?

    enum CodingKeys: String, CodingKey {
        case message
        case insertedAt = "inserted_at"
        case listenedAt = "listened_at"
        case listenedAtISO = "listened_at_iso"
        case playingNow = "playing_now"
        case trackMetadata = "track_metadata"
        case userName = "user_name"
        case created
        case relationshipType = "relationship_type"
        case userName0 = "user_name_0"
        case userName1 = "user_name_1"
        case blurbContent = "blurb_content"
    }
}
