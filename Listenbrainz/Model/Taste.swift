//
//  Taste.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 18/08/24.
//

import Foundation


struct Taste: Codable, Identifiable {
    let id = UUID()
    let created: Int
    let recordingMbid: String?
    let recordingMsid: String?
    let score: Int?
    let trackMetadata: TrackMetadata?

    enum CodingKeys: String, CodingKey {
        case created
        case recordingMbid = "recording_mbid"
        case recordingMsid = "recording_msid"
        case score
        case trackMetadata = "track_metadata"
    }
}

struct TrackMetadata: Codable {
    let artistName: String
    let releaseName: String?
    let trackName: String?
    let mbidMapping: MbidMapping?

    enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case releaseName = "release_name"
        case trackName = "track_name"
        case mbidMapping = "mbid_mapping"
    }
}

struct MbidMapping: Codable {
    let artistMbids: [String]
    let caaID: Int?
    let caaReleaseMbid: String?

    enum CodingKeys: String, CodingKey {
        case artistMbids = "artist_mbids"
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
    }
}

struct TasteResponse: Codable {
    let count: Int
    let feedback: [Taste]
}


enum SongCategory {
    case loved, hated
}



extension Taste: TrackMetadataProvider {
    var trackName: String? {
        return trackMetadata?.trackName
    }

    var artistName: String? {
        return trackMetadata?.artistName
    }

    var coverArtURL: URL? {
        guard let caaReleaseMbid = trackMetadata?.mbidMapping?.caaReleaseMbid,
              let caaID = trackMetadata?.mbidMapping?.caaID else {
            return nil
        }
        return URL(string: "\(Constants.COVER_ART_BASE_URL)\(caaReleaseMbid)/\(caaID)-250.jpg")
    }

    var originURL: String? {
        return nil
    }


    var entityName: String? {
        return nil
    }
}
