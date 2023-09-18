//
//  ArtistElement.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - ArtistElement
struct ArtistElement: Codable {
    let artistCreditName, artistMbid, joinPhrase: String

    enum CodingKeys: String, CodingKey {
        case artistCreditName = "artist_credit_name"
        case artistMbid = "artist_mbid"
        case joinPhrase = "join_phrase"
    }
}
