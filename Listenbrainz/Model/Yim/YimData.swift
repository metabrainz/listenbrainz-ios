//
//  YimData.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation

// MARK: - YIMData
struct YIMData: Codable {
    let payload: YimPayload
}

// MARK: - Payload
struct YimPayload: Codable {
    let data: DataClass
    let userName: String

    enum CodingKeys: String, CodingKey {
        case data
        case userName = "user_name"
    }
}
