//
//  Count.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/08/24.
//

import Foundation

struct CountResponse: Codable {
    let payload: CountPayload
}

struct CountPayload: Codable {
    let count: Int
}

