//
//  FeedRepository.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation
import Combine
import Alamofire

protocol FeedRepository {
  func fetchFeedData(userName: String,userToken:String) -> AnyPublisher<FeedAlbum, AFError>
}

