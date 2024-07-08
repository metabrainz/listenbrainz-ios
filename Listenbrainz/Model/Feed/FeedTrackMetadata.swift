//
//  FeedTrackMetadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation

struct FeedTrackMetadata: Codable {
  let additionalInfo: FeedAdditionalInfo?
  let artistName: String
  let trackName: String
  let mbidMapping: FeedMbidMapping?

  enum CodingKeys: String, CodingKey {
    case additionalInfo = "additional_info"
    case artistName = "artist_name"
    case trackName = "track_name"
    case mbidMapping = "mbid_mapping"
  }

  var coverArtURL: URL? {
    guard let caaReleaseMbid = mbidMapping?.caaReleaseMbid,
          let caaID = mbidMapping?.caaID else {
      return nil
    }
    return URL(string: "\(Constants.COVER_ART_BASE_URL)\(caaReleaseMbid)/\(caaID)-250.jpg")
  }
}

