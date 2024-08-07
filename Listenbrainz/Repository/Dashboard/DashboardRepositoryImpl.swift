//
//  DashboardRepositoryImpl.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/07/24.
//

import Foundation
import Combine
import Alamofire

class DashboardRepositoryImpl: DashboardRepository {
  func getListenCount(userName: String) -> AnyPublisher<CountPayload, AFError> {
    let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/listen-count"
    guard let url = URL(string: urlString) else {
      return Fail(error: AFError.invalidURL(url: urlString)).eraseToAnyPublisher()
    }

    return AF.request(url, method: .get)
      .validate()
      .publishDecodable(type: CountResponse.self)
      .value()
      .map { $0.payload }
      .eraseToAnyPublisher()
  }
  func getFollowers(userName: String) -> AnyPublisher<Followers, AFError> {
    let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/followers"
    guard let url = URL(string: urlString) else {
      return Fail(error: AFError.invalidURL(url: urlString)).eraseToAnyPublisher()
    }
    return AF.request(url, method: .get)
      .validate()
      .publishDecodable(type: Followers.self)
      .value()
      .eraseToAnyPublisher()
  }

  func getFollowing(userName: String) -> AnyPublisher<Following, AFError> {
    let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/following"
    guard let url = URL(string: urlString) else {
      return Fail(error: AFError.invalidURL(url: urlString)).eraseToAnyPublisher()
    }
    return AF.request(url, method: .get)
      .validate()
      .publishDecodable(type: Following.self)
      .value()
      .eraseToAnyPublisher()
  }
  
}




