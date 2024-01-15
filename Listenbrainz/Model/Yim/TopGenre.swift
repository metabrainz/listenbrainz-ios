//
//  TopGenre.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation


// MARK: - TopGenre
struct TopGenre: Codable {
    let genre: String
    let genreCount: Int
    let genreCountPercent: Double

    enum CodingKeys: String, CodingKey {
        case genre
        case genreCount = "genre_count"
        case genreCountPercent = "genre_count_percent"
    }
}
