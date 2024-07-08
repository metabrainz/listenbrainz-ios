//
//  FeedAdditionalInfo.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation

struct FeedAdditionalInfo: Codable {
    let originURL: String?
    let recordingMbid: String?
    let recordingMsid: String

    enum CodingKeys: String, CodingKey {
        case originURL = "origin_url"
        case recordingMbid = "recording_mbid"
        case recordingMsid = "recording_msid"
    }
}
