//
//  musicModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import Foundation

struct MusicModel: Codable {
    let payload: Payload
}


enum MusicService: String, Codable {
    case spotifyCOM = "spotify.com"
}

enum SubmissionClient: String, Codable {
    case listenbrainz = "listenbrainz"
}


enum JoinPhrase: String, Codable {
    case empty = ""
    case feat = " feat. "
}

enum User: String, Codable {
    case gb1307 = "gb1307"
}


