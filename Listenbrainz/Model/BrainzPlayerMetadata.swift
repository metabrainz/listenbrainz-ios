//
//  BrainzPlayerMetadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 26/06/23.
//

import Foundation

// MARK: - BrainzplayerMetadata
struct BrainzplayerMetadata: Codable {
    let artistName, releaseName, trackName: String

    enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case releaseName = "release_name"
        case trackName = "track_name"
    }
}
