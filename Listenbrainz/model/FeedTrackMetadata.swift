//
//  FeedTrackMetadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


//MARK: - TrackMetadata
struct FeedTrackMetadata: Codable {
    let additionalInfo: FeedAdditionalInfo?
    let artistName: String
    let mbidMapping: FeedMbidMapping
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
