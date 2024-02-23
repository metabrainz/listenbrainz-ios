
//  Payload.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.


import Foundation


// MARK: - ListensPayload
struct ListensPayload: Codable {
  let listens: [Listen]

  enum CodingKeys: String, CodingKey {
    case listens
  }
}
