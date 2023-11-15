//
//  ListensArtist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


// MARK: - Artist
struct ListensArtist: Codable {
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
    case featuring = " featuring "
    case joinPhrase = " & "
}


