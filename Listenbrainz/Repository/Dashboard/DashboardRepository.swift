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
  func getTaste(userName: String) -> AnyPublisher<TasteResponse, AFError> 
  func getPinTrack(userName: String) -> AnyPublisher<Pins, AFError>

  func getPlaylists(userName: String) -> AnyPublisher<PlaylistResponse, AFError>
  func getCreatedForYou(userName: String) -> AnyPublisher<[CreatedForYouContainer], AFError>
  func getCreatedForYouPlaylist(playlistId: String) -> AnyPublisher<PlaylistDetails, AFError>
  func validateUserToken(userToken: String) async throws -> TokenValidation
}
