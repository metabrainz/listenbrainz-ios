//
//  MbidMapping.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - MbidMapping
struct MbidMapping: Codable {
    let artistMbids: [String]?
    let artists: [ArtistElement]?
    let caaID: Int?
    let caaReleaseMbid, recordingMbid, recordingName, releaseMbid: String?

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
