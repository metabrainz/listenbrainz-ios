//
//  ListensPerDay.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation


// MARK: - ListensPerDay
struct ListensPerDay: Codable {
    let fromTs: Int
    let listenCount: Int
    let timeRange: String
    let toTs: Int

    enum CodingKeys: String, CodingKey {
        case fromTs = "from_ts"
        case listenCount = "listen_count"
        case timeRange = "time_range"
        case toTs = "to_ts"
    }
}
