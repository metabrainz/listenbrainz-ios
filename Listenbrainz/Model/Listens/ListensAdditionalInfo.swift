//
//  AdditionalInfo.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 06/06/23.
//

import Foundation

// MARK: - ListensAdditionalInfo
struct ListensAdditionalInfo: Codable {
  let originURL: String?

  enum CodingKeys: String, CodingKey {
    case originURL = "origin_url"
  }
}


