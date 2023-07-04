//
//  TrackMetadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation



//MARK: - TrackMetadata
struct TrackMetadata: Codable {
    let additionalInfo: AdditionalInfo
    let artistName: String
    let mbidMapping: MbidMapping?
    let releaseName: String?
    let  trackName: String

    enum CodingKeys: String, CodingKey {
        case additionalInfo = "additional_info"
        case artistName = "artist_name"
        case mbidMapping = "mbid_mapping"
        case releaseName = "release_name"
        case trackName = "track_name"
    }
}
