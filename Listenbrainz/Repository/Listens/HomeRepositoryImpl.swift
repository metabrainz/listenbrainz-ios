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

    let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/listens")!


    return AF.request(url, method: .get)
      .validate()
      .publishDecodable(type: Listens.self)
      .value()
      .eraseToAnyPublisher()
  }
}
