//
//  FeedMbidMapping.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


// MARK: - FeedMbidMapping
struct FeedMbidMapping: Codable {
    let artistMbids: [String]?
    let artists: [FeedArtist]?
    let recordingMbid: String?
    let recordingName: String?
    let caaID: Int?
    let caaReleaseMbid, releaseMbid: String?

    enum CodingKeys: String, CodingKey {
        case artistMbids = "artist_mbids"
        case artists
        case recordingMbid = "recording_mbid"
        case recordingName = "recording_name"
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
        case releaseMbid = "release_mbid"
    }
}
