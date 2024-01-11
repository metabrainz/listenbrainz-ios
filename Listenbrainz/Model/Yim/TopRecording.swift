//
//  TopRecording.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation


// MARK: - TopRecording
struct TopRecording: Codable {
//    let artistMbids: [String]
    let artistName: String
//    let listenCount: Int
    let trackName: String
//    let artists: [AdditionalMetadataArtist]?
//    let caaID: Int?
//    let caaReleaseMbid, recordingMbid, releaseMbid: String?

    enum CodingKeys: String, CodingKey {
//        case artistMbids = "artist_mbids"
        case artistName = "artist_name"
//        case listenCount = "listen_count"
//        case releaseName = "release_name"
        case trackName = "track_name"
//        case artists
//        case caaID = "caa_id"
//        case caaReleaseMbid = "caa_release_mbid"
//        case recordingMbid = "recording_mbid"
//        case releaseMbid = "release_mbid"
    }
}
