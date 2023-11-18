//
//  MbidMapping.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - ListensMbidMapping
struct ListensMbidMapping: Codable {
    let artistMbids: [String]
    let artists: [Artist]
    let caaID: Int?
    let caaReleaseMbid: String?
    let recordingMbid, recordingName: String
    let releaseMbid: String?

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

