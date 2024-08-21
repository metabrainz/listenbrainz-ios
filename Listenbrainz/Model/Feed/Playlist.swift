//
//  Playlist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import Foundation

// MARK: - PlaylistResponse
struct PlaylistResponse: Codable {
    let count: Int
    let offset: Int
    let playlistCount: Int
    let playlists: [PlaylistWrapper]

    enum CodingKeys: String, CodingKey {
        case count, offset
        case playlistCount = "playlist_count"
        case playlists
    }
}

// MARK: - PlaylistWrapper
struct PlaylistWrapper: Codable {
    let playlist: Playlist
}

// MARK: - Playlist
struct Playlist: Codable {
    let annotation: String?
    let creator: String
    let date: String
    let extensionData: ExtensionData
    let identifier: String
    let title: String
    let tracks: [Track]

    enum CodingKeys: String, CodingKey {
        case annotation, creator, date
        case extensionData = "extension"
        case identifier = "identifier"
        case title, tracks = "track"
    }
}

// MARK: - ExtensionData
struct ExtensionData: Codable {
    let playlistInfo: PlaylistInfo

    enum CodingKeys: String, CodingKey {
        case playlistInfo = "https://musicbrainz.org/doc/jspf#playlist"
    }
}

// MARK: - PlaylistInfo
struct PlaylistInfo: Codable {
    let creator: String
    let lastModifiedAt: String
    let isPublic: Bool

    enum CodingKeys: String, CodingKey {
        case creator
        case lastModifiedAt = "last_modified_at"
        case isPublic = "public"
    }
}


