//
//  ListensArtist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation


// MARK: - Artist
struct Artist: Codable {
    let payload: ListensPayload?
    let name: String?
    let founded: Int?
    let members: [String]?
}

