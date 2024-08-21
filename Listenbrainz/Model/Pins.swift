//
//  Pins.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 18/08/24.
//

import Foundation


struct Pins: Codable {

    let pinnedRecordings: [PinnedRecording]?

    enum CodingKeys: String, CodingKey {
        case pinnedRecordings = "pinned_recordings"
    }
}

// MARK: - PinnedRecording
struct PinnedRecording: Codable {

    var id = UUID()
    let trackMetadata: PinsTrackMetadata
    let recordingMbid: String?
    let recordingMsid: String?

    enum CodingKeys: String, CodingKey {
      case trackMetadata = "track_metadata"
      case recordingMbid = "recording_mbid"
      case recordingMsid = "recording_msid"
    }
}


struct PinsTrackMetadata: Codable {
    let artistName: String
    let mbidMapping: PinsMbidMapping?
    let trackName: String

  enum CodingKeys: String, CodingKey {
        case artistName = "artist_name"
        case mbidMapping = "mbid_mapping"
        case trackName = "track_name"
    }
}



struct PinsMbidMapping: Codable {
    let caaID: Int?
    let caaReleaseMbid: String?

    enum CodingKeys: String, CodingKey {
        case caaID = "caa_id"
        case caaReleaseMbid = "caa_release_mbid"
    }
}

extension PinnedRecording: TrackMetadataProvider {

    var trackName: String? {
      return trackMetadata.trackName
    }

    var artistName: String? {
        return trackMetadata.artistName
    }

    var coverArtURL: URL? {
      guard let caaReleaseMbid = trackMetadata.mbidMapping?.caaReleaseMbid,
            let caaID = trackMetadata.mbidMapping?.caaID else {
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
