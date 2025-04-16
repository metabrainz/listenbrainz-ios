//
//  TokenValidation.swift
//  Listenbrainz
//
//  Created by Jasjeet Singh on 17/04/25.
//

struct TokenValidation: Codable {
    let code: Int
    let message: String
    var username: String? = nil
    let valid: Bool
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
        case username = "user_name"
        case valid = "valid"
    }
}
