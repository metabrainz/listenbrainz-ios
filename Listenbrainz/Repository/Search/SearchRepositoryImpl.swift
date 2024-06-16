//
//  SearchRepositoryImpl.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/24.
//

import Foundation
import Combine
import Alamofire

class SearchRepositoryImpl: SearchRepository {

    func searchUsers(term: String) -> AnyPublisher<UserSearchResponse, AFError> {
        let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/search/users?search_term=\(term)"
        guard let url = URL(string: urlString) else {
            return Fail(error: AFError.invalidURL(url: urlString)).eraseToAnyPublisher()
        }

        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: UserSearchResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}

