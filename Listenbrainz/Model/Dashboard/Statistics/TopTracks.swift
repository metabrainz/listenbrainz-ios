//
//  TopTracks.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import Foundation


struct TopTracks: Codable{
  let payload: TracksPayload
}

struct TracksPayload: Codable {
    let recordings: [Recording]

    enum CodingKeys: String, CodingKey {
        case recordings
    }
}

struct Recording: Codable {
    let artistName: String
    let caaID: Int?
    let caaReleaseMbid: String?
    let listenCount: Int
    let trackName: String

    enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
        case listenCount = "listen_count"
        case trackName = "track_name"
    }

  var coverArtURL: URL? {
    guard let caaReleaseMbid = caaReleaseMbid,
          let caaID = caaID else {
      return nil
    }
    return URL(string: "\(Constants.COVER_ART_BASE_URL)\(caaReleaseMbid)/\(caaID)-250.jpg")
  }
}
