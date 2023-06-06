//
//  Album.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


// MARK: - Album
struct Album: Codable {
    let name: String
    let artist: Artist
    let tracks: [Track]
}
