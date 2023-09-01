//
//  Track.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


// MARK: - Track
struct Track: Codable {
    let name: String
    let duration: Int
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let album = try? JSONDecoder().decode(Album.self, from: jsonData)
//   let track = try? JSONDecoder().decode(Track.self, from: jsonData)

//import Foundation
//
//// MARK: - Album
//struct Album: Codable {
//    let payload: ListensPayload
//}

//// MARK: - Payload
//struct Payload: Codable {
//    let count, latestListenTs: Int
//    let listens: [Listen]
//    let userID: User
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case latestListenTs = "latest_listen_ts"
//        case listens
//        case userID = "user_id"
//    }
//}
//
//// MARK: - Listen
//struct Listen: Codable {
//    let insertedAt, listenedAt: Int
//    let recordingMsid: String
//    let trackMetadata: TrackMetadata
//    let userName: User
//
//    enum CodingKeys: String, CodingKey {
//        case insertedAt = "inserted_at"
//        case listenedAt = "listened_at"
//        case recordingMsid = "recording_msid"
//        case trackMetadata = "track_metadata"
//        case userName = "user_name"
//    }
//}
//
//// MARK: - TrackMetadata
//struct TrackMetadata: Codable {
//    let additionalInfo: AdditionalInfo
//    let artistName: String
//    let mbidMapping: MbidMapping?
//    let releaseName, trackName: String
//
//    enum CodingKeys: String, CodingKey {
//        case additionalInfo = "additional_info"
//        case artistName = "artist_name"
//        case mbidMapping = "mbid_mapping"
//        case releaseName = "release_name"
//        case trackName = "track_name"
//    }
//}
//
//// MARK: - AdditionalInfo
//struct AdditionalInfo: Codable {
//    let durationMS: Int
//    let mediaPlayer: MediaPlayer
//    let recordingMsid: String
//
//    enum CodingKeys: String, CodingKey {
//        case durationMS = "duration_ms"
//        case mediaPlayer = "media_player"
//        case recordingMsid = "recording_msid"
//    }
//}
//
//enum MediaPlayer: String, Codable {
//    case spotify = "Spotify"
//}
//
//// MARK: - MbidMapping
//struct MbidMapping: Codable {
//    let artistMbids: [String]
//    let artists: [Artist]
//    let caaID: Int?
//    let caaReleaseMbid: String?
//    let recordingMbid, recordingName: String
//    let releaseMbid: String?
//
//    enum CodingKeys: String, CodingKey {
//        case artistMbids = "artist_mbids"
//        case artists
//        case caaID = "caa_id"
//        case caaReleaseMbid = "caa_release_mbid"
//        case recordingMbid = "recording_mbid"
//        case recordingName = "recording_name"
//        case releaseMbid = "release_mbid"
//    }
//}
//
//// MARK: - Artist
//struct Artist: Codable {
//    let artistCreditName, artistMbid: String
//    let joinPhrase: JoinPhrase
//
//    enum CodingKeys: String, CodingKey {
//        case artistCreditName = "artist_credit_name"
//        case artistMbid = "artist_mbid"
//        case joinPhrase = "join_phrase"
//    }
//}
//
//enum JoinPhrase: String, Codable {
//    case empty = ""
//    case joinPhrase = " & "
//}
//
//enum User: String, Codable {
//    case gb1307 = "gb1307"
//}
//
//// MARK: - Track
//struct Track: Codable {
//    let name: String
//    let duration: Int
//}
