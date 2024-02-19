//
//  Listen.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - Listen
struct Listen: Codable {
    let recordingMsid: String
    let trackMetadata: ListensTrackMetadata?

    enum CodingKeys: String, CodingKey {
        case recordingMsid = "recording_msid"
        case trackMetadata = "track_metadata"
    }
}
