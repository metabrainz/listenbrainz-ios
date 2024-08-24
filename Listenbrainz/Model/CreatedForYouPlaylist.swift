//
//  CreatedForYouPlaylist.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 24/08/24.
//

import Foundation

// MARK: - PlaylistDetailsResponse
struct PlaylistDetailsResponse: Codable {
    let playlist: PlaylistDetails

    enum CodingKeys: String, CodingKey {
        case playlist = "playlist"
    }
}

// MARK: - PlaylistDetails
struct PlaylistDetails: Codable {
    let track: [PlaylistTrack]

    enum CodingKeys: String, CodingKey {
        case track = "track"
    }
}

// MARK: - PlaylistTrack
struct PlaylistTrack: Codable, Identifiable {
    var id = UUID()
    let album: String
    let creator: String
    let trackExtension: PlaylistTrackExtension
    let title: String
    let identifier: [String]  

    enum CodingKeys: String, CodingKey {
        case album, creator
        case trackExtension = "extension"
        case title
        case identifier
    }
}

// MARK: - TrackExtension
struct PlaylistTrackExtension: Codable {
    let jsfpTrack: JspfTrack

    enum CodingKeys: String, CodingKey {
        case jsfpTrack = "https://musicbrainz.org/doc/jspf#track"
    }
}

// MARK: - JspfTrack
struct JspfTrack: Codable {
    let additionalMetadata: HTTPSMusicbrainzOrgDocJspfTrackAdditionalMetadata

    enum CodingKeys: String, CodingKey {
        case additionalMetadata = "additional_metadata"
    }
}

// MARK: - HTTPSMusicbrainzOrgDocJspfTrackAdditionalMetadata
struct HTTPSMusicbrainzOrgDocJspfTrackAdditionalMetadata: Codable {
    let caaID: Int?
    let caaReleaseMbid: String?

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
    }
}

// MARK: - TrackAdditionalMetadata
struct TrackAdditionalMetadata: Codable {
    let caaID: Int?
    let caaReleaseMbid: String?

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
    }
}

extension PlaylistTrack: TrackMetadataProvider {
    var trackName: String? {
        return title
    }

    var artistName: String? {
        return creator
    }

    var coverArtURL: URL? {
        guard let caaID = trackExtension.jsfpTrack.additionalMetadata.caaID,
              let caaReleaseMbid = trackExtension.jsfpTrack.additionalMetadata.caaReleaseMbid else {
            return nil
        }
        return URL(string: "\(Constants.COVER_ART_BASE_URL)\(caaReleaseMbid)/\(caaID)-250.jpg")
    }

    var originURL: String? {
        return nil
    }


    var recordingMbid: String? {

        if let musicBrainzRecordingURL = identifier.first(where: { $0.contains("musicbrainz.org/recording/") }) {
            return musicBrainzRecordingURL.components(separatedBy: "/").last
        }
        return nil
    }

    var recordingMsid: String? {
      if let musicBrainzRecordingURL = identifier.first(where: { $0.contains("musicbrainz.org/recording/") }) {
          return musicBrainzRecordingURL.components(separatedBy: "/").last
      }
      return nil
    }

    var entityName: String? {
        return nil
    }
}

