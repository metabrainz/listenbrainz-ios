//
//  NewRelasesOfTopArtist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation


// MARK: - NewReleasesOfTopArtist
struct NewReleasesOfTopArtist: Codable {
//    let artistCreditMbids: [String]
    let artistCreditName: String
    let caaID: Int?
    let caaReleaseMbid: String?
    let title: String

    enum CodingKeys: String, CodingKey {
//        case artistCreditMbids = "artist_credit_mbids"
        case artistCreditName = "artist_credit_name"
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
//        case releaseGroupMbid = "release_group_mbid"
        case title
    }
}
