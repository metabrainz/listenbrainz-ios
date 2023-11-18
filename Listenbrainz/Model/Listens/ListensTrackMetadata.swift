//
//  TrackMetadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation




//MARK: - ListensTrackMetadata
struct ListensTrackMetadata: Codable {
    let additionalInfo: ListensAdditionalInfo
    let artistName: String
    let releaseName: String?
    let trackName: String
    let mbidMapping: ListensMbidMapping?
    let brainzplayerMetadata: BrainzplayerMetadata?

    enum CodingKeys: String, CodingKey {
        case additionalInfo = "additional_info"
        case artistName = "artist_name"
        case releaseName = "release_name"
        case trackName = "track_name"
        case mbidMapping = "mbid_mapping"
        case brainzplayerMetadata = "brainzplayer_metadata"
    }
}
