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

  func getListeningActivity(userName: String) -> AnyPublisher<ActivityPayload, AFError> {
         let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/stats/user/\(userName)/listening-activity"
         print("Fetching from URL: \(urlString)")

         guard let url = URL(string: urlString) else {
             return Fail(error: AFError.invalidURL(url: urlString))
                 .eraseToAnyPublisher()
         }

         return AF.request(url, method: .get)
             .validate()
             .publishDecodable(type: ActivityResponse.self) 
             .value()
             .map { $0.payload }
             .eraseToAnyPublisher()
     }

  func getTopArtists(userName: String) -> AnyPublisher<ArtistsPayload, AFError> {
    let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/stats/user/\(userName)/artists"
    print("Fetching from URL: \(urlString)")

    guard let url = URL(string: urlString) else {
        return Fail(error: AFError.invalidURL(url: urlString))
            .eraseToAnyPublisher()
    }

    return AF.request(url, method: .get)
        .validate()
        .publishDecodable(type: TopArtists.self)
        .value()
        .map { $0.payload }
        .eraseToAnyPublisher()
     }

  func getTopAlbums(userName: String) -> AnyPublisher<AlbumsPayload, AFError> {
    let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/stats/user/\(userName)/releases"
    print("Fetching from URL: \(urlString)")

    guard let url = URL(string: urlString) else {
        return Fail(error: AFError.invalidURL(url: urlString))
            .eraseToAnyPublisher()
    }

    return AF.request(url, method: .get)
        .validate()
        .publishDecodable(type: TopAlbums.self)
        .value()
        .map { $0.payload }
        .eraseToAnyPublisher()

  }

  func getTopTracks(userName: String) -> AnyPublisher<TracksPayload, AFError> {
    let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/stats/user/\(userName)/recordings"
    print("Fetching from URL: \(urlString)")

    guard let url = URL(string: urlString) else {
        return Fail(error: AFError.invalidURL(url: urlString))
            .eraseToAnyPublisher()
    }

    return AF.request(url, method: .get)
        .validate()
        .publishDecodable(type: TopTracks.self)
        .value()
        .map { $0.payload }
        .eraseToAnyPublisher()
    }

  func getDailyActivity(userName: String) -> AnyPublisher<DailyActivityPayload, AFError> {
    let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/stats/user/\(userName)/daily-activity"
    print("Fetching from URL: \(urlString)")

    guard let url = URL(string: urlString) else {
        return Fail(error: AFError.invalidURL(url: urlString))
            .eraseToAnyPublisher()
    }

    return AF.request(url, method: .get)
        .validate()
        .publishDecodable(type: DailyActivityResponse.self)
        .value()
        .map { $0.payload }
        .eraseToAnyPublisher()
  }


 }




