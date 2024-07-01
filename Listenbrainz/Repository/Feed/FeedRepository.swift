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
    func fetchFeedData(userName: String, userToken: String) -> AnyPublisher<FeedAlbum, AFError>
    func fetchCoverArt(url: URL) -> AnyPublisher<Data, AFError>
    func pinTrack(recordingMsid: String, recordingMbid: String?, blurbContent: String?, userToken: String) -> AnyPublisher<Void, AFError>
    func deleteEvent(userName: String, eventID: Int, userToken: String) -> AnyPublisher<Void, AFError>
    func recommendToFollowers(userName: String, item: TrackMetadataProvider, userToken: String) -> AnyPublisher<Void, AFError>
    func recommendToUsersPersonally(userName: String, item: TrackMetadataProvider, users: [String], blurbContent: String, userToken: String) -> AnyPublisher<Void, AFError>
}


