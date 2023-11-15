//
//  FeedAdditionalInfo.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 31/08/23.
//

import Foundation



struct FeedAdditionalInfo: Codable {
    let artistMbids: [String]?
    let discnumber, durationMS: Int?
    let isrc, listeningFrom: String?
    let originURL: String?
    let recordingMbid: String?
    let recordingMsid: String
    let releaseArtistName: String?
    let releaseArtistNames: [String]?
    let releaseGroupMbid, releaseMbid: String?
    let spotifyAlbumArtistIDS: [String]?
    let spotifyAlbumID: String?
    let spotifyArtistIDS: [String]?
    let spotifyID: String?
    let tags: JSONNull?
    let trackMbid, tracknumber: String?
    let workMbids: [String]?
    let youtubeID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case artistMbids = "artist_mbids"
        case discnumber
        case durationMS = "duration_ms"
        case isrc
        case listeningFrom = "listening_from"
        case originURL = "origin_url"
        case recordingMbid = "recording_mbid"
        case recordingMsid = "recording_msid"
        case releaseArtistName = "release_artist_name"
        case releaseArtistNames = "release_artist_names"
        case releaseGroupMbid = "release_group_mbid"
        case releaseMbid = "release_mbid"
        case spotifyAlbumArtistIDS = "spotify_album_artist_ids"
        case spotifyAlbumID = "spotify_album_id"
        case spotifyArtistIDS = "spotify_artist_ids"
        case spotifyID = "spotify_id"
        case tags
        case trackMbid = "track_mbid"
        case tracknumber
        case workMbids = "work_mbids"
        case youtubeID = "youtube_id"
    }
}
