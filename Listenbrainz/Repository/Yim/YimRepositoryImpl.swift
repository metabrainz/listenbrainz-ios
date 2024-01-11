//
//  YimRepositoryImpl.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Combine
import Alamofire

class YIMRepositoryImpl: YIMRepository {
    func fetchYIMData(userName:String) -> AnyPublisher<YIMData, Error> {
        let url = "https://beta-api.listenbrainz.org/1/stats/user/\(userName)/year-in-music/2023"

        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: YIMData.self)
            .value()
            .mapError { $0 as Error } // Convert AFError to a more general Error
            .eraseToAnyPublisher()
    }
}

