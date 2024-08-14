//
//  DashboardRepository.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/07/24.
//

import Foundation
import Combine
import Alamofire

protocol DashboardRepository{
  func getListenCount(userName:String) -> AnyPublisher<CountPayload,AFError>
  func getFollowers(userName:String) -> AnyPublisher<Followers, AFError>
  func getFollowing(userName:String) -> AnyPublisher<Following, AFError>

  // MARK: - Statistics
  func getListeningActivity(userName: String) -> AnyPublisher<ActivityPayload, AFError>
  func getTopArtists(userName:String) -> AnyPublisher<ArtistsPayload, AFError>
  func getTopAlbums(userName:String) -> AnyPublisher<AlbumsPayload, AFError>
  func getTopTracks(userName:String) -> AnyPublisher<TracksPayload, AFError>
  func getDailyActivity(userName:String) -> AnyPublisher<DailyActivityPayload, AFError>
}
