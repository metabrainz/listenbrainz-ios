//
//  MbidMapping.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - ListensMbidMapping
struct ListensMbidMapping: Codable {
    let caaID: Int?
    let caaReleaseMbid: String?
    let recordingMbid: String?

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
        case recordingMbid = "recording_mbid"
    }
}

