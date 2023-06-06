//
//  Listen.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - Listen
struct Listen: Codable {
    let insertedAt, listenedAt: Int
    let recordingMsid: String
    let trackMetadata: TrackMetadata
    let userName: String

    enum CodingKeys: String, CodingKey {
        case insertedAt = "inserted_at"
        case listenedAt = "listened_at"
        case recordingMsid = "recording_msid"
        case trackMetadata = "track_metadata"
        case userName = "user_name"
    }
}
