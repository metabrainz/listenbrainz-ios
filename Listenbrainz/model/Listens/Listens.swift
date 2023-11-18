//
//  Listens.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import Foundation

struct Listens: Codable {
    let payload: ListensPayload
}



struct CombinedModel: Codable {
    let listensPayload: ListensPayload
    let feedPayload: FeedPayload
}

// MARK: - Album
struct Album: Codable {
    let name: String
    let artist: ListensArtist
    let tracks: [Track]
}



