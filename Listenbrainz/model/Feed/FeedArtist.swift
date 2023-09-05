
//  Artist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.


import Foundation

// MARK: - FeedArtist
struct FeedArtist: Codable {
    let artistCreditName, artistMbid: String
    let joinPhrase: JoinPhrase

    enum CodingKeys: String, CodingKey {
        case artistCreditName = "artist_credit_name"
        case artistMbid = "artist_mbid"
        case joinPhrase = "join_phrase"
    }
}

enum JoinPhrase: String, Codable {
    case empty = ""
    case feat = " feat. "
    case joinPhrase = " & "
    case purple = ", "
}

enum User: String, Codable {
    case akshaaatt = "akshaaatt"
    case gb1307 = "gb1307"
    case jasjeet = "Jasjeet"
}
