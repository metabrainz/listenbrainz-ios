//
//  FeedRepositoryImpl.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation
import Alamofire
import Combine

class FeedRepositoryImpl: FeedRepository {


  func fetchFeedData(userName: String,userToken:String) -> AnyPublisher<FeedAlbum, AFError> {
        let url = URL(string: "https://api.listenbrainz.org/1/user/\(userName)/feed/events")!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(userToken)"
        ]

        return AF.request(url, method: .get, headers: headers)
            .validate()
            .publishDecodable(type: FeedAlbum.self)
            .value()
            .eraseToAnyPublisher()
    }
}

