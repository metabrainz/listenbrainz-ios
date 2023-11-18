//
//  Metadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation

// MARK: - Metadata
struct Metadata: Codable {
    let blurbContent: String?
    let created: Int?
    let entityId: String?
    let entityName: String?
    let entityType: String?
    let insertedAt: Int?
    let listenedAt: Int?
    //let listenedAtIso: JSONNull?
    let message: String?
    //let playingNow: JSONNull?
    let rating: Int?
    let relationshipType: String?
    let reviewMbid: String?
    let text: String?
    let trackMetadata: FeedTrackMetadata?
    let username: String?
    let usersList: [String]?
    let userName0: String?
    let userName1: String?

    enum CodingKeys: String, CodingKey {
        case blurbContent = "blurb_content"
        case created
        case entityId = "entity_id"
        case entityName = "entity_name"
        case entityType = "entity_type"
        case insertedAt = "inserted_at"
        case listenedAt = "listened_at"
        //case listenedAtIso = "listened_at_iso"
        case message
        //case playingNow = "playing_now"
        case rating
        case relationshipType = "relationship_type"
        case reviewMbid = "review_mbid"
        case text
        case trackMetadata
        case username
        case usersList = "users"
        case userName0 = "user_name_0"
        case userName1 = "user_name_1"
    }
}
