//
//  Metadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation


struct Metadata: Codable {
    let insertedAt, listenedAt: Int?
    let listenedAtISO, playingNow: JSONNull?
    let trackMetadata: FeedTrackMetadata?
    let userName: User?
    let created: Int?
    let relationshipType: String?
    let userName0: User?
    let userName1, entityID, entityName, entityType: String?
    let rating: Int?
    let reviewMbid, text: String?
    let blurbContent: String?

    enum CodingKeys: String, CodingKey {
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
        case entityID = "entity_id"
        case entityName = "entity_name"
        case entityType = "entity_type"
        case rating
        case reviewMbid = "review_mbid"
        case text
        case blurbContent = "blurb_content"
    }
}
enum User: String, Codable {
    case akshaaatt = "akshaaatt"
    case gb1307 = "gb1307"
    case jasjeet = "Jasjeet"
}
