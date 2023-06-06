//
//  Payload.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation


//MARK: - Payload
struct Payload: Codable {
    let count, latestListenTs: Int
    let listens: [Listen]
    let userID: User

    enum CodingKeys: String, CodingKey {
        case count
        case latestListenTs = "latest_listen_ts"
        case listens
        case userID = "user_id"
    }
}
