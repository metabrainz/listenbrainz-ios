//
//  Metadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation

// MARK: - Metadata
struct Metadata: Codable {
    let trackMetadata: FeedTrackMetadata?
    let blurbContent: String?
    let username: String?
    let userName0: String?
    let userName1: String?
    let message: String?
    let text:String?
    let rating: Int?
    let entityName:String?

    enum CodingKeys: String, CodingKey {
        case trackMetadata = "track_metadata"
        case blurbContent = "blurb_content"
        case username
        case userName0 = "user_name_0"
        case userName1 = "user_name_1"
        case message,text,rating
        case entityName = "entity_name"
    }
}
