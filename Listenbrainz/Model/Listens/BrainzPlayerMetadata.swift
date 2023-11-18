//
//  BrainzPlayerMetadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/11/23.
//

// MARK: - BrainzplayerMetadata
struct BrainzplayerMetadata: Codable {
    let trackName: String

    enum CodingKeys: String, CodingKey {
        case trackName = "track_name"
    }
}

