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
    private let authToken = "bd7a7694-d600-406c-befb-13c6f3e564c7"

    func fetchMusicData(userName: String) -> AnyPublisher<ListensAlbum, AFError> {
        let url = URL(string: "https://api.listenbrainz.org/1/user/\(userName)/feed/events")!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(authToken)"
        ]

        return AF.request(url, method: .get, headers: headers)
            .validate()
            .publishDecodable(type: ListensAlbum.self)
            .value()
            .eraseToAnyPublisher()
    }
}

