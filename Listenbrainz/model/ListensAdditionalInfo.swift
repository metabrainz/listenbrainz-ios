//
//  AdditionalInfo.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation

// MARK: - AdditionalInfo
struct ListensAdditionalInfo: Codable {
    let durationMS: Int
    let mediaPlayer: MediaPlayer
    let recordingMsid: String

    enum CodingKeys: String, CodingKey {
        case durationMS = "duration_ms"
        case mediaPlayer = "media_player"
        case recordingMsid = "recording_msid"
    }
}

enum MediaPlayer: String, Codable {
    case spotify = "Spotify"
}
