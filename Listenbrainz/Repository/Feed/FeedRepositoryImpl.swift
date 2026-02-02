//
//  FeedRepositoryImpl.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Foundation
import Combine
import Alamofire

class FeedRepositoryImpl: FeedRepository {

    func fetchFeedData(userName: String, userToken: String, count: Int, maxTs: Int64?, minTs: Int64?) -> AnyPublisher<FeedAlbum, AFError> {
        let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/feed/events"
        return makeFeedRequest(url: urlString, userToken: userToken, count: count, maxTs: maxTs, minTs: minTs)
    }
    
    func fetchFollowListens(userName: String, userToken: String, count: Int, maxTs: Int64?, minTs: Int64?) -> AnyPublisher<FeedAlbum, AFError> {
        let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/feed/events/listens/following"
        return makeFeedRequest(url: urlString, userToken: userToken, count: count, maxTs: maxTs, minTs: minTs)
    }
    
    func fetchSimilarListens(userName: String, userToken: String, count: Int, maxTs: Int64?, minTs: Int64?) -> AnyPublisher<FeedAlbum, AFError> {
        let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/feed/events/listens/similar"
        return makeFeedRequest(url: urlString, userToken: userToken, count: count, maxTs: maxTs, minTs: minTs)
    }
    
    private func makeFeedRequest(url: String, userToken: String, count: Int, maxTs: Int64?, minTs: Int64?) -> AnyPublisher<FeedAlbum, AFError> {
        var parameters: [String: Any] = ["count": count]
        if let maxTs = maxTs { parameters["max_ts"] = maxTs }
        if let minTs = minTs { parameters["min_ts"] = minTs }

        let headers: HTTPHeaders = ["Authorization": "Token \(userToken)"]

        return AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .publishDecodable(type: FeedAlbum.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func fetchCoverArt(url: URL) -> AnyPublisher<Data, AFError> {
        return AF.request(url, method: .get).validate().publishData().value().eraseToAnyPublisher()
    }

    func pinTrack(recordingMsid: String, recordingMbid: String?, blurbContent: String?, userToken: String) -> AnyPublisher<Void, AFError> {
        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/pin")!
        let parameters: [String: Any] = [
            "recording_msid": recordingMsid,
            "recording_mbid": recordingMbid ?? NSNull(),
            "blurb_content": blurbContent ?? "",
            "pinned_until": Int(Date().timeIntervalSince1970 + 7 * 24 * 60 * 60)
        ]
        let headers: HTTPHeaders = ["Authorization": "Token \(userToken)", "Content-Type": "application/json"]
        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate().publishData().value().map { _ in () }.eraseToAnyPublisher()
    }

    func deleteEvent(userName: String, eventID: Int, eventType: String, userToken: String) -> AnyPublisher<Void, AFError> {
        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/feed/events/delete")!
        let parameters: [String: Any] = ["event_type": eventType, "id": eventID]
        let headers: HTTPHeaders = ["Authorization": "Token \(userToken)", "Content-Type": "application/json"]
        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate().publishData().value().map { _ in () }.eraseToAnyPublisher()
    }

    func recommendToFollowers(userName: String, item: TrackMetadataProvider, userToken: String) -> AnyPublisher<Void, AFError> {
        var metadata: [String: Any] = [:]
        metadata["recording_msid"] = item.recordingMsid ?? NSNull()
        metadata["recording_mbid"] = item.recordingMbid ?? NSNull()

        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/timeline-event/create/recording")!
        let parameters: [String: Any] = ["metadata": metadata]
        let headers: HTTPHeaders = ["Authorization": "Token \(userToken)", "Content-Type": "application/json"]
        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate().publishData().value().map { _ in () }.eraseToAnyPublisher()
    }

    func recommendToUsersPersonally(userName: String, item: TrackMetadataProvider, users: [String], blurbContent: String, userToken: String) -> AnyPublisher<Void, AFError> {
        var metadata: [String: Any] = ["users": users, "blurb_content": blurbContent]
        metadata["recording_msid"] = item.recordingMsid ?? NSNull()
        metadata["recording_mbid"] = item.recordingMbid ?? NSNull()

        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/timeline-event/create/recording")!
        let parameters: [String: Any] = ["metadata": metadata]
        let headers: HTTPHeaders = ["Authorization": "Token \(userToken)", "Content-Type": "application/json"]
        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate().publishData().value().map { _ in () }.eraseToAnyPublisher()
    }

    func writeAReview(userName: String, item: TrackMetadataProvider, userToken: String, entityName: String, entityId: String, entityType: String, text: String, language: String, rating: Int) -> AnyPublisher<Void, AFError> {
        guard item.trackName != nil,
              item.recordingMsid != nil,
              text.count >= 25,
              (1...5).contains(rating) else {
            return Fail<Void, AFError>(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }

        let url = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/timeline-event/create/review"
        let parameters: [String: Any] = [
            "metadata": [
                "entity_name": entityName,
                "entity_id": entityId,
                "entity_type": entityType,
                "text": text,
                "language": "en",
                "rating": rating
            ]
        ]
        let headers: HTTPHeaders = ["Authorization": "Token \(userToken)", "Content-Type": "application/json"]
        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate().publishData().value().map { _ in () }.eraseToAnyPublisher()
    }
}
