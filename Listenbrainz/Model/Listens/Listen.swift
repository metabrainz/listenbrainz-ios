//
//  Listen.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - Listen
struct Listen: Codable, TrackMetadataProvider {
     var id: Int?
     let recordingMsid: String?
     let trackMetadata: ListensTrackMetadata?

    enum CodingKeys: String, CodingKey {
        case id
        case recordingMsid = "recording_msid"
        case trackMetadata = "track_metadata"

    }

    var trackName: String? { trackMetadata?.trackName }
    var artistName: String? { trackMetadata?.artistName }
    var coverArtURL: URL? { trackMetadata?.coverArtURL }
    var originURL: String? { trackMetadata?.additionalInfo?.originURL }
    var recordingMbid: String? { trackMetadata?.mbidMapping?.recordingMbid }
    var entityName: String? { trackMetadata?.entityName }
}
