//
//  CreatedForYou.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import Foundation

// MARK: - CreatedForYouResponse
struct CreatedForYouResponse: Codable {
    let count: Int
    let offset: Int
    let playlistCount: Int
    let playlists: [CreatedForYouContainer]

    enum CodingKeys: String, CodingKey {
        case count, offset
        case playlistCount = "playlist_count"
        case playlists
    }
}

// MARK: - CreatedForYouContainer
struct CreatedForYouContainer: Codable {
    let playlist: CreatedForYou
}

// MARK: - CreatedForYou
struct CreatedForYou: Codable {
    let annotation: String
    let creator: String
    let date: String
    let extensionData: CreatedForYouExtension
    let identifier: String
    let title: String
    let track: [String]

    enum CodingKeys: String, CodingKey {
        case annotation, creator, date, identifier, title, track
        case extensionData = "extension"
    }
}

// MARK: - CreatedForYouExtension
struct CreatedForYouExtension: Codable {
    let metadata: CreatedAdditionalMetadata

    enum CodingKeys: String, CodingKey {
        case metadata = "https://musicbrainz.org/doc/jspf#playlist"
    }
}

// MARK: - CreatedAdditionalMetadata
struct CreatedAdditionalMetadata: Codable {
    let algorithmMetadata: AlgorithmMetadata?

    enum CodingKeys: String, CodingKey {
        case algorithmMetadata = "algorithm_metadata"
    }
}

// MARK: - AlgorithmMetadata
struct AlgorithmMetadata: Codable {
    let sourcePatch: String
    let expiresAt: String?

    enum CodingKeys: String, CodingKey {
        case sourcePatch = "source_patch"
        case expiresAt = "expires_at"
    }
}



