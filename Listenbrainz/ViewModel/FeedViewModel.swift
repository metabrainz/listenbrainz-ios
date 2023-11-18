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



  func fetchFeedEvents(username: String,userToken:String) {
        repository.fetchFeedData(userName: username,userToken: userToken)
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
            })
            .store(in: &subscriptions)
    }
}

