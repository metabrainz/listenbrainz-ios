//
//  HomeRepositoryImpl.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import Foundation
import Alamofire
import Combine

class HomeRepositoryImpl: HomeRepository {

  func fetchMusicData(userName:String) -> AnyPublisher<Listens, AFError> {
        let url = URL(string: "https://api.listenbrainz.org/1/user/\(userName)/listens")!


        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: Listens.self)
            .value()
            .eraseToAnyPublisher()
    }
}
