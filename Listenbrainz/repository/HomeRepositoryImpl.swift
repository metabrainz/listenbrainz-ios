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

    func fetchMusicData() -> AnyPublisher<MusicModel, AFError> {
        let url = URL(string: "https://api.listenbrainz.org/1/user/gb1307/listens")!

        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: MusicModel.self)
            .value()
            .eraseToAnyPublisher()
    }
}
