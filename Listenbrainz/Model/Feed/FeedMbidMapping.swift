//
//  FeedMbidMapping.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


// MARK: - FeedMbidMapping
struct FeedMbidMapping: Codable {
    let caaID: Int?
    let caaReleaseMbid, releaseMbid: String?

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
        case releaseMbid = "release_mbid"
    }
}
