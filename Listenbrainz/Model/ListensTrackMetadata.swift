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
    let mbidMapping: ListensMbidMapping?
    let releaseName, trackName: String

    enum CodingKeys: String, CodingKey {
        case additionalInfo = "additional_info"
        case artistName = "artist_name"
        case mbidMapping = "mbid_mapping"
        case releaseName = "release_name"
        case trackName = "track_name"
    }
}
