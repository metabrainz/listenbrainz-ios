//
//  SearchRepository.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/06/24.
//

import Foundation
import Combine
import Alamofire

protocol SearchRepository {
    func searchUsers(term: String) -> AnyPublisher<UserSearchResponse, AFError>
}

