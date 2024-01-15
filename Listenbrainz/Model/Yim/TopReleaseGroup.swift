//
//  TopReleaseGroup.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation


// MARK: - TopReleaseGroup
struct TopReleaseGroup: Codable {
//    let artistMbids: [String]
//    let artistName: String
//    let listenCount: Int
    let releaseGroupName: String
//    let artists: [AdditionalMetadataArtist]?
    let caaID: Int?
    let caaReleaseMbid: String?

    enum CodingKeys: String, CodingKey {
//        case artistMbids = "artist_mbids"
//        case artistName = "artist_name"
//        case listenCount = "listen_count"
        case releaseGroupName = "release_group_name"
//        case artists
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
//        case releaseGroupMbid = "release_group_mbid"
    }
}
