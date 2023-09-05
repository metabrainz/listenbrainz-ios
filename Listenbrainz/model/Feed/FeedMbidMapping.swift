//
//  FeedMbidMapping.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


// MARK: - FeedMbidMapping
struct FeedMbidMapping: Codable {
    let artistMbids: [String]
    let artists: [FeedArtist]
    let caaID: Int?
    let caaReleaseMbid: String?
    let recordingMbid: String
    let recordingName: String?
    let releaseMbid: String

    enum CodingKeys: String, CodingKey {
        case artistMbids = "artist_mbids"
        case artists
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
        case recordingMbid = "recording_mbid"
        case recordingName = "recording_name"
        case releaseMbid = "release_mbid"
    }
}
