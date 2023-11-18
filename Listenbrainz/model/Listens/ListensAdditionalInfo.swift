//
//  AdditionalInfo.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation

// MARK: - ListensAdditionalInfo
struct ListensAdditionalInfo: Codable {
    let artistNames: [String]?
    let discnumber: Int?
    let durationMS: Int?
    let isrc: String?
    let musicService: MusicService?
    let originURL: String?
    let recordingMsid: String
    let releaseArtistName: String?
    let releaseArtistNames: [String]?
    let spotifyAlbumArtistIDS: [String]?
    let spotifyAlbumID: String?
    let spotifyArtistIDS: [String]?
    let spotifyID: String?
    let submissionClient: String?
    let tracknumber: Int?
    let mediaPlayer, submissionClientVersion, musicServiceName: String?

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
        case mediaPlayer = "media_player"
        case submissionClientVersion = "submission_client_version"
        case musicServiceName = "music_service_name"
    }
}

enum MusicService: String, Codable {
    case spotifyCOM = "spotify.com"
    case youtubeCOM = "youtube.com"
}

enum SubmissionClient: String, Codable {
    case brainzPlayer = "BrainzPlayer"
    case listenBrainzAndroid = "ListenBrainz Android"
    case listenbrainz = "listenbrainz"
}
