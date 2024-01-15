//
//  TopArtistElement.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation


// MARK: - TopArtistElement
struct TopArtistElement: Codable {
    let artistMbid: String?
    let artistName: String
    let listenCount: Int

    enum CodingKeys: String, CodingKey {
        case artistMbid = "artist_mbid"
        case artistName = "artist_name"
        case listenCount = "listen_count"
    }
}
