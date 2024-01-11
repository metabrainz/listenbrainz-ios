//
//  TopDiscoveries.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation

// MARK: - TopDiscoveries
struct TopDiscoveries: Codable {
    let playlist: Playlist?
}

// MARK: - Playlist

struct Playlist: Codable {
//    let annotation: String
//    let creator: Creator
//    let date: DateEnum
//    let playlistExtension: PlaylistTopDiscoveriesForYearExtension
    let identifier: String
    let title: String
    let track: [TrackElement]?

    enum CodingKeys: String, CodingKey {
//        case annotation, creator, date
//        case playlistExtension = "extension"
        case identifier, title, track
    }
}

// MARK: - TrackElement
struct TrackElement: Codable {
    let album, creator: String
    let trackExtension: TrackExtension?
    let identifier: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case album, creator
        case trackExtension = "extension"
        case identifier, title
    }
}

// MARK: - TrackExtension
struct TrackExtension: Codable {
    let httpsMusicbrainzOrgDocJspfTrack: HTTPSMusicbrainzOrgDocJspfTrack?

    enum CodingKeys: String, CodingKey {
        case httpsMusicbrainzOrgDocJspfTrack = "https://musicbrainz.org/doc/jspf#track"
    }
}

// MARK: - HTTPSMusicbrainzOrgDocJspfTrack
struct HTTPSMusicbrainzOrgDocJspfTrack: Codable {

    let additionalMetadata: AdditionalMetadata?
    let artistIdentifiers: [String]

    enum CodingKeys: String, CodingKey {

        case additionalMetadata = "additional_metadata"
        case artistIdentifiers = "artist_identifiers"
    }
}





// MARK: - AdditionalMetadata
struct AdditionalMetadata: Codable {
//    let artists: [AdditionalMetadataArtist]
    let caaID: Int?
    let caaReleaseMbid: String?

    enum CodingKeys: String, CodingKey {
//        case artists
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
    }
}
