//
//  musicModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import Foundation

struct MusicModel: Codable {
    let payload: Payload
}

struct Payload: Codable {
    let count, latestListenTs: Int
    let listens: [Listen]
    let userID: User

    enum CodingKeys: String, CodingKey {
        case count
        case latestListenTs = "latest_listen_ts"
        case listens
        case userID = "user_id"
    }
}

struct Listen: Codable {
    let insertedAt, listenedAt: Int
    let recordingMsid: String
    let trackMetadata: TrackMetadata
    let userName: User

    enum CodingKeys: String, CodingKey {
        case insertedAt = "inserted_at"
        case listenedAt = "listened_at"
        case recordingMsid = "recording_msid"
        case trackMetadata = "track_metadata"
        case userName = "user_name"
    }
}

struct TrackMetadata: Codable {
    let additionalInfo: AdditionalInfo
    let artistName: String
    let mbidMapping: MbidMapping?
    let releaseName, trackName: String

    enum CodingKeys: String, CodingKey {
        case additionalInfo = "additional_info"
        case artistName = "artist_name"
        case mbidMapping = "mbid_mapping"
        case releaseName = "release_name"
        case trackName = "track_name"
    }
}

struct AdditionalInfo: Codable {
    let artistNames: [String]
    let discnumber, durationMS: Int
    let isrc: String
    let musicService: MusicService
    let originURL: String
    let recordingMsid, releaseArtistName: String
    let releaseArtistNames: [String]
    let spotifyAlbumArtistIDS: [String]
    let spotifyAlbumID: String
    let spotifyArtistIDS: [String]
    let spotifyID: String
    let submissionClient: SubmissionClient
    let tracknumber: Int

    enum CodingKeys: String, CodingKey {
        case artistNames = "artist_names"
        case discnumber
        case durationMS = "duration_ms"
        case isrc
        case musicService = "music_service"
        case originURL = "origin_url"
        case recordingMsid = "recording_msid"
        case releaseArtistName = "release_artist_name"
        case releaseArtistNames = "release_artist_names"
        case spotifyAlbumArtistIDS = "spotify_album_artist_ids"
        case spotifyAlbumID = "spotify_album_id"
        case spotifyArtistIDS = "spotify_artist_ids"
        case spotifyID = "spotify_id"
        case submissionClient = "submission_client"
        case tracknumber
    }
}

enum MusicService: String, Codable {
    case spotifyCOM = "spotify.com"
}

enum SubmissionClient: String, Codable {
    case listenbrainz = "listenbrainz"
}

struct MbidMapping: Codable {
    let artistMbids: [String]
    let artists: [Artist]
    let caaID: Int
    let caaReleaseMbid, recordingMbid, recordingName, releaseMbid: String

    enum CodingKeys: String, CodingKey {
        case artistMbids = "artist_mbids"
        case artists
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
        case recordingMbid = "recording_mbid"
        case recordingName = "recording_name"
        case releaseMbid = "release_mbid"
    }
}

struct Artist: Codable {
    let artistCreditName, artistMbid: String
    let joinPhrase: JoinPhrase

    enum CodingKeys: String, CodingKey {
        case artistCreditName = "artist_credit_name"
        case artistMbid = "artist_mbid"
        case joinPhrase = "join_phrase"
    }
}

enum JoinPhrase: String, Codable {
    case empty = ""
    case feat = " feat. "
}

enum User: String, Codable {
    case gb1307 = "gb1307"
}

