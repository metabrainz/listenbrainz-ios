//
//  TopArtists.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import Foundation

struct TopArtists:Codable {
  let payload:ArtistsPayload
}

struct ArtistsPayload: Codable {
    let artists: [ArtistElement]

    enum CodingKeys: String, CodingKey {
        case artists
    }
}

struct ArtistElement: Codable {
    let artistName: String
    let listenCount: Int

    enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case listenCount = "listen_count"
    }
}
