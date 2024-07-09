//
//  FeedViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import SwiftUI
import Combine
import Foundation

class FeedViewModel: ObservableObject {
    @Published var feedData: FeedAlbum?
    @Published var events: [Event] = []

    private var subscriptions: Set<AnyCancellable> = []
    var repository: FeedRepository

    init(repository: FeedRepository) {
        self.repository = repository
    }

    func fetchFeedEvents(username: String, userToken: String) {
        repository.fetchFeedData(userName: username, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("API Error: \(error)")
                }
            }, receiveValue: { data in
                self.feedData = data
                self.events = data.payload.events
                if let firstEvent = self.events.first {
                    self.fetchCoverArt(for: firstEvent)
                }
            })
            .store(in: &subscriptions)
    }

    private func fetchCoverArt(for event: Event) {
        guard let coverArtURL = event.metadata.trackMetadata?.coverArtURL else {
            return
        }

        repository.fetchCoverArt(url: coverArtURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Cover art fetched successfully")
                case .failure(let error):
                    print("Error fetching cover art: \(error)")
                }
            }, receiveValue: { data in
                // Handle the fetched cover art data if needed
            })
            .store(in: &subscriptions)
    }

    func pinTrack(recordingMsid: String, recordingMbid: String?, blurbContent: String?, userToken: String) {
        repository.pinTrack(recordingMsid: recordingMsid, recordingMbid: recordingMbid, blurbContent: blurbContent, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Track pinned successfully")
                case .failure(let error):
                    print("Error pinning track: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    func deleteEvent(userName: String, eventID: Int, userToken: String) {
        repository.deleteEvent(userName: userName, eventID: eventID, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Event deleted successfully")
                    self.events.removeAll { $0.id == eventID }
                case .failure(let error):
                    print("Error deleting event: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    func recommendToFollowers(userName: String, item: TrackMetadataProvider, userToken: String) {
        repository.recommendToFollowers(userName: userName, item: item, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Recommended to followers successfully")
                case .failure(let error):
                    print("Error recommending to followers: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    func recommendToUsersPersonally(userName: String, item: TrackMetadataProvider, users: [String], blurbContent: String, userToken: String) {
        repository.recommendToUsersPersonally(userName: userName, item: item, users: users, blurbContent: blurbContent, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Recommended to users personally successfully")
                case .failure(let error):
                    print("Error recommending to users personally: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

  func writeAReview(userName:String, item: TrackMetadataProvider, userToken: String, entityName: String, entityId:String, entityType:String, text:String, language:String, rating:Int){
    repository.writeAReview(userName: userName, item: item, userToken: userToken, entityName: entityName, entityId: entityId, entityType: entityType, text: text, language: language, rating: rating)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .finished:
              print("Review added successfully")
          case .failure(let error):
              print("Error adding review: \(error)")
          }
      }, receiveValue: { _ in })
      .store(in: &subscriptions)
  }
}




