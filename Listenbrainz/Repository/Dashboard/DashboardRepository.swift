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
}
