//
//  MbidMapping.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - ListensMbidMapping
struct ListensMbidMapping: Codable {
//    let artists: [ListensArtist]?
    let caaID: Int?
    let caaReleaseMbid: String?

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
    }
}

