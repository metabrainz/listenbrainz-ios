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
    let username: String?
    let userName0: String?
    let userName1: String?

    enum CodingKeys: String, CodingKey {
        case trackMetadata = "track_metadata"
        case username
        case userName0 = "user_name_0"
        case userName1 = "user_name_1"
    }
}
