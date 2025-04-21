//
//  Event.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation


// MARK: - Event
struct Event: Codable, Identifiable, TrackMetadataProvider, Equatable {
    let created: Int
    let eventType: String
    let hidden: Bool
    let metadata: Metadata
    let id: Int?
    let userName: String

    enum CodingKeys: String, CodingKey {
        case created
        case eventType = "event_type"
        case hidden, metadata, id
        case userName = "user_name"
    }

    var trackName: String? { metadata.trackMetadata?.trackName }
    var artistName: String? { metadata.trackMetadata?.artistName }
    var coverArtURL: URL? { metadata.trackMetadata?.coverArtURL }
    var originURL: String? { metadata.trackMetadata?.additionalInfo?.originURL }
    var recordingMbid: String? { metadata.trackMetadata?.additionalInfo?.recordingMbid }
    var recordingMsid: String? { metadata.trackMetadata?.additionalInfo?.recordingMsid }
    var entityName: String? { metadata.entityName }
    var blurbContent: String? { metadata.message ?? metadata.blurbContent ?? metadata.text }

    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id &&
               lhs.created == rhs.created
    }
}


protocol TrackMetadataProvider {
    var trackName: String? { get }
    var artistName: String? { get }
    var coverArtURL: URL? { get }
    var originURL: String? { get }
    var recordingMbid: String? { get }
    var recordingMsid: String? { get }
    var entityName: String? { get }
}



