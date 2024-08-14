//
//  ListeningActivity.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import Foundation

struct ActivityResponse: Codable {
    let payload: ActivityPayload
}

struct ActivityPayload: Codable {
    let fromTs, lastUpdated: Int
    let listeningActivity: [ListeningActivity]
    let range: String
    let toTs: Int
    let userID: String

    enum CodingKeys: String, CodingKey {
        case fromTs = "from_ts"
        case lastUpdated = "last_updated"
        case listeningActivity = "listening_activity"
        case range
        case toTs = "to_ts"
        case userID = "user_id"
    }
}


struct ListeningActivity: Codable, Identifiable {
    let fromTs, listenCount: Int
    let timeRange: String
    let toTs: Int
    var id: Int {
        return fromTs.hashValue ^ toTs.hashValue &* 16777619
    }

    enum CodingKeys: String, CodingKey {
        case fromTs = "from_ts"
        case listenCount = "listen_count"
        case timeRange = "time_range"
        case toTs = "to_ts"
    }
}

