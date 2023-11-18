
//  Artist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.


import Foundation

// MARK: - FeedArtist
struct FeedArtist: Codable {
    let artistCreditName, artistMbid: String
    let joinPhrase: String

    enum CodingKeys: String, CodingKey {
        case artistCreditName = "artist_credit_name"
        case artistMbid = "artist_mbid"
        case joinPhrase = "join_phrase"
    }
}


