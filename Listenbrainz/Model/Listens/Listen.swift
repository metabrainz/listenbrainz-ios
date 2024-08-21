//
//  Listen.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - Listen
struct Listen: Codable, TrackMetadataProvider, Equatable {
     var id: Int?
     var uuid = UUID()
     let recordingMsid: String?
     let trackMetadata: ListensTrackMetadata?

    enum CodingKeys: String, CodingKey {
        case id
        case recordingMsid = "recording_msid"
        case trackMetadata = "track_metadata"

    }
  static func == (lhs: Listen, rhs: Listen) -> Bool {
      return lhs.id == rhs.id &&
             lhs.recordingMsid == rhs.recordingMsid
  }

    var trackName: String? { trackMetadata?.trackName }
    var artistName: String? { trackMetadata?.artistName }
    var coverArtURL: URL? { trackMetadata?.coverArtURL }
    var originURL: String? { trackMetadata?.additionalInfo?.originURL }
    var recordingMbid: String? { trackMetadata?.mbidMapping?.recordingMbid }
    var entityName: String? { trackMetadata?.entityName }
}
