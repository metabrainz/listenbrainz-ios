//
//  Artist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let payload: Payload?
    let name: String?
    let founded: Int?
    let members: [String]?
}
