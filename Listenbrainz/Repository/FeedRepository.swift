//
//  FeedRepository.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation
import Combine
import Alamofire

protocol FeedRepository {
    func fetchMusicData(userName: String) -> AnyPublisher<ListensAlbum, AFError>
}

