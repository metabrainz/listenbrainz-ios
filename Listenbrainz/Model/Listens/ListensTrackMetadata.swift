//
//  TrackMetadata.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation




//MARK: - ListensTrackMetadata
struct ListensTrackMetadata: Codable {
    let additionalInfo: ListensAdditionalInfo?
    let artistName: String
    let trackName: String
    let mbidMapping: ListensMbidMapping?
    let entityName:String?

    enum CodingKeys: String, CodingKey {
        case additionalInfo = "additional_info"
        case artistName = "artist_name"
        case trackName = "track_name"
        case mbidMapping = "mbid_mapping"
        case entityName = "entity_name"
    }

  var coverArtURL: URL? {
        guard let caaReleaseMbid = mbidMapping?.caaReleaseMbid, let caaID = mbidMapping?.caaID else {
            return nil
        }
        return URL(string: "https://coverartarchive.org/release/\(caaReleaseMbid)/\(caaID)-250.jpg")
    }
}
