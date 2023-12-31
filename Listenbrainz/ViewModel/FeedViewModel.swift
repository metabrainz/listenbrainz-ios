//
//  FeedViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import Alamofire
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

    AF.request(coverArtURL, method: .get)
      .validate()
      .responseData { [weak self] response in
        guard self != nil else { return }

        switch response.result {
        case .success(_):
          print("Cover art fetched successfully")
        case .failure(let error):
          print("Error fetching cover art: \(error)")
        }
      }
  }
}
