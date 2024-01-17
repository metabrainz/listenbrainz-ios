//
//  TopDiscoveries.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation

// MARK: - PlaylistTopSForYear
struct PlaylistTopSForYear: Codable {

  let identifier: String
    let track: [TrackElement]?

    enum CodingKeys: String, CodingKey {

      case identifier
        case track
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
 

    enum CodingKeys: String, CodingKey {

        case additionalMetadata = "additional_metadata"

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
