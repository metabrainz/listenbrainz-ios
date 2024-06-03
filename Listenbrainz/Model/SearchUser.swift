//
//  SearchUser.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 03/06/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id = UUID()
    let userName: String

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
    }
}

struct UserSearchResponse: Codable {
    let users: [User]
}

