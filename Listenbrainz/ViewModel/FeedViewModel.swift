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
    @Published var isLoading: Bool = false
    @Published var isInitialLoad = true
    @Published var canLoadMorePages: Bool = true

      private var currentPage: Int = 1
      private let itemsPerPage: Int = 25
      private var loadedEventIDs: Set<Int> = []

    private var subscriptions: Set<AnyCancellable> = []
    var repository: FeedRepository

    init(repository: FeedRepository) {
        self.repository = repository
    }

  func fetchFeedEvents(username: String, userToken: String) async throws {
          guard !isLoading && canLoadMorePages else { return }

          DispatchQueue.main.async {
              self.isLoading = true
          }

          defer {
              DispatchQueue.main.async {
                  self.isLoading = false
                  self.isInitialLoad = false
              }
          }

          try await withCheckedThrowingContinuation { continuation in
              repository.fetchFeedData(userName: username, userToken: userToken, page: currentPage, perPage: itemsPerPage)
                  .receive(on: DispatchQueue.main)
                  .sink(receiveCompletion: { completion in
                      switch completion {
                      case .finished:
                          continuation.resume()
                      case .failure(let error):
                          continuation.resume(throwing: error)
                      }
                  }, receiveValue: { data in
                      let newEvents = data.payload.events
                      if newEvents.isEmpty {
                          self.canLoadMorePages = false
                      } else {
                          self.currentPage += 1
                          self.events.append(contentsOf: newEvents)
                      }
                  })
                  .store(in: &self.subscriptions)
          }
      }

      func resetPagination() {
          currentPage = 1
          canLoadMorePages = true
          events.removeAll()
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




