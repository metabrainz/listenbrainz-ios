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
    @Published var feedData: ListensAlbum?
    @Published var events: [Event] = []

  private var subscriptions: Set<AnyCancellable> = []

    private let repository: FeedRepository = FeedRepositoryImpl()

    func fetchFeedEvents(username: String) {
        repository.fetchMusicData(userName: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Handle finished if needed
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

