//
//  FeedViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import SwiftUI
import Combine
import Alamofire

enum FeedType{
    case events
    case following
    case similar
}

class FeedViewModel: ObservableObject {
    @Published var feedData: FeedAlbum?
    @Published var events: [Event] = []
    @Published var isLoading: Bool = false
    @Published var isInitialLoad = true
    @Published var canLoadMorePages: Bool = true
    @Published var feedType: FeedType = .events

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

      await MainActor.run { self.isLoading = true }

      defer {
          Task { @MainActor in
              self.isLoading = false
              self.isInitialLoad = false
          }
      }
      let maxTs: Int64?
      if isInitialLoad {
          maxTs = nil
      } else {
          if let lastCreated = events.last?.created {
              maxTs = Int64(lastCreated)
          } else {
              maxTs = nil
          }
      }
      return try await withCheckedThrowingContinuation { continuation in
          let publisher: AnyPublisher<FeedAlbum, AFError>
              switch feedType {
                  case .events:
                      publisher = repository.fetchFeedData(userName: username, userToken: userToken, count: itemsPerPage, maxTs: maxTs, minTs: nil)
                  case .following:
                      publisher = repository.fetchFollowListens(userName: username, userToken: userToken, count: itemsPerPage, maxTs: maxTs, minTs: nil)
                  case .similar:
                      publisher = repository.fetchSimilarListens(userName: username, userToken: userToken, count: itemsPerPage, maxTs: maxTs, minTs: nil)
              }
              publisher
                  .receive(on: DispatchQueue.main)
                  .sink(receiveCompletion: { completion in
                      switch completion {
                      case .finished:
                          continuation.resume()
                      case .failure(let error):
                          continuation.resume(throwing: error)
                      }
                  }, receiveValue: { [weak self] (data : FeedAlbum) in
                      guard let self else { return }
                      let newEvents = data.payload.events
                      
                      if newEvents.isEmpty {
                          self.canLoadMorePages = false
                      } else {
                          let uniqueEvents = newEvents.filter { event in
                              if let id = event.id as? Int {
                                  return !self.loadedEventIDs.contains(id)
                              }
                              return true // If no ID, keep it (risky but better than losing data)
                          }
                          
                          uniqueEvents.forEach { event in
                              if let id = event.id as? Int {
                                  self.loadedEventIDs.insert(id)
                              }
                          }
                          self.events.append(contentsOf: uniqueEvents)
                      }
                  })
                  .store(in: &self.subscriptions)
          }
      }
    func changeFeedType(to type: FeedType) {
        feedType = type
        resetPagination()
    }

      func resetPagination() {
          isInitialLoad = true
          canLoadMorePages = true
          events.removeAll()
          loadedEventIDs.removeAll()
      }



    private func fetchCoverArt(for event: Event) {
        guard let coverArtURL = event.metadata.trackMetadata?.coverArtURL else {
            return
        }

        repository.fetchCoverArt(url: coverArtURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    func pinTrack(recordingMsid: String, recordingMbid: String?, blurbContent: String?, userToken: String) {
        repository.pinTrack(recordingMsid: recordingMsid, recordingMbid: recordingMbid, blurbContent: blurbContent, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    func deleteEvent(userName: String, eventID: Int, eventType: String, userToken: String) {
        repository.deleteEvent(userName: userName, eventID: eventID, eventType: eventType, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .finished = completion {
                    self?.events.removeAll { $0.id == eventID }
                    self?.loadedEventIDs.remove(eventID)
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    func recommendToFollowers(userName: String, item: TrackMetadataProvider, userToken: String) {
        repository.recommendToFollowers(userName: userName, item: item, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    func recommendToUsersPersonally(userName: String, item: TrackMetadataProvider, users: [String], blurbContent: String, userToken: String) {
        repository.recommendToUsersPersonally(userName: userName, item: item, users: users, blurbContent: blurbContent, userToken: userToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

  func writeAReview(userName:String, item: TrackMetadataProvider, userToken: String, entityName: String, entityId:String, entityType:String, text:String, language:String, rating:Int){
    repository.writeAReview(userName: userName, item: item, userToken: userToken, entityName: entityName, entityId: entityId, entityType: entityType, text: text, language: language, rating: rating)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
      .store(in: &subscriptions)
  }
}




