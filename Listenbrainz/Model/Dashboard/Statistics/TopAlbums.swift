//
//  TopAlbums.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import Foundation

struct TopAlbums:Codable{
  let payload:AlbumsPayload
}

struct AlbumsPayload: Codable {
    let releases: [Release]

    enum CodingKeys: String, CodingKey {
        case releases
    }
}

// MARK: - Release
struct Release: Codable {
    let caaID: Int?
    let caaReleaseMbid: String?
    let listenCount:Int
    let artistName: String
    let releaseName:String

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
        case listenCount = "listen_count"
        case artistName = "artist_name"
        case releaseName = "release_name"
    }
  var coverArtURL: URL? {
    guard let caaReleaseMbid = caaReleaseMbid,
          let caaID = caaID else {
      return nil
    }
    return URL(string: "\(Constants.COVER_ART_BASE_URL)\(caaReleaseMbid)/\(caaID)-250.jpg")
  }
}
