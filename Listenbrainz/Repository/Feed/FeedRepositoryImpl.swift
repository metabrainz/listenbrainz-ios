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

    func fetchFeedData(userName: String, userToken: String) -> AnyPublisher<FeedAlbum, AFError> {
        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/feed/events")!
        let headers: HTTPHeaders = [
            "Authorization": "Token \(userToken)"
        ]

        return AF.request(url, method: .get, headers: headers)
            .validate()
            .publishDecodable(type: FeedAlbum.self)
            .value()
            .mapError { $0.asAFError ?? .explicitlyCancelled }
            .eraseToAnyPublisher()
    }

    func fetchCoverArt(url: URL) -> AnyPublisher<Data, AFError> {
        return AF.request(url, method: .get)
            .validate()
            .publishData()
            .value()
            .mapError { $0.asAFError ?? .explicitlyCancelled }
            .eraseToAnyPublisher()
    }

    func pinTrack(recordingMsid: String, recordingMbid: String?, blurbContent: String?, userToken: String) -> AnyPublisher<Void, AFError> {
        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/pin")!
        let parameters: [String: Any] = [
            "recording_msid": recordingMsid,
            "recording_mbid": recordingMbid ?? NSNull(),
            "blurb_content": blurbContent ?? "",
            "pinned_until": Int(Date().timeIntervalSince1970 + 7 * 24 * 60 * 60) // 1 week in the future
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Token \(userToken)",
            "Content-Type": "application/json"
        ]

        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishData()
            .tryMap { _ in () }
            .mapError { $0.asAFError ?? .explicitlyCancelled }
            .eraseToAnyPublisher()
    }

    func deleteEvent(userName: String, eventID: Int, userToken: String) -> AnyPublisher<Void, AFError> {
        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/feed/events/delete")!
        let parameters: [String: Any] = [
            "event_type": "recording_recommendation",
            "id": eventID
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Token \(userToken)",
            "Content-Type": "application/json"
        ]

        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishData()
            .tryMap { _ in () }
            .mapError { $0.asAFError ?? .explicitlyCancelled }
            .eraseToAnyPublisher()
    }

    func recommendToFollowers(userName: String, item: TrackMetadataProvider, userToken: String) -> AnyPublisher<Void, AFError> {
        var metadata: [String: Any] = [:]

        if let recordingMsid = item.recordingMsid {
            metadata["recording_msid"] = recordingMsid
        } else {
            metadata["recording_msid"] = NSNull()
        }

        if let recordingMbid = item.recordingMbid {
            metadata["recording_mbid"] = recordingMbid
        } else {
            metadata["recording_mbid"] = NSNull()
        }

        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/timeline-event/create/recording")!
        let parameters: [String: Any] = [
            "metadata": metadata
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Token \(userToken)",
            "Content-Type": "application/json"
        ]

        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishData()
            .tryMap { _ in () }
            .mapError { $0.asAFError ?? .explicitlyCancelled }
            .eraseToAnyPublisher()
    }

    func recommendToUsersPersonally(userName: String, item: TrackMetadataProvider, users: [String], blurbContent: String, userToken: String) -> AnyPublisher<Void, AFError> {
        var metadata: [String: Any] = [
            "users": users,
            "blurb_content": blurbContent
        ]

        if let recordingMsid = item.recordingMsid {
            metadata["recording_msid"] = recordingMsid
        } else {
            metadata["recording_msid"] = NSNull()
        }

        if let recordingMbid = item.recordingMbid {
            metadata["recording_mbid"] = recordingMbid
        } else {
            metadata["recording_mbid"] = NSNull()
        }

        let url = URL(string: "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/user/\(userName)/timeline-event/create/recording")!
        let parameters: [String: Any] = [
            "metadata": metadata
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Token \(userToken)",
            "Content-Type": "application/json"
        ]

        return AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishData()
            .tryMap { _ in () }
            .mapError { $0.asAFError ?? .explicitlyCancelled }
            .eraseToAnyPublisher()
    }
}
