//
//  HomeViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import SwiftUI
import Combine
import Alamofire

class HomeViewModel: ObservableObject {
  @Published var listens: [Listen] = []
  private var subscriptions: Set<AnyCancellable> = []
  var repository: HomeRepository

  init(repository: HomeRepository) {
    self.repository = repository
  }

  func requestMusicData(userName: String) {
    repository.fetchMusicData(userName: userName)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        print(completion)
      }, receiveValue: { value in
        self.listens = value.payload.listens
        if let firstListen = self.listens.first,
           let coverArtURL = firstListen.trackMetadata.coverArtURL {
          self.fetchCoverArt(url: coverArtURL) { result in
            switch result {
            case .success(_):
              print("Cover art fetched successfully")
            case .failure(let error):
              print("Error fetching cover art: \(error)")
            }
          }
        }
      })
      .store(in: &subscriptions)
  }



  private func fetchCoverArt(url: URL, completion: @escaping (Result<Data, AFError>) -> Void) {
    AF.request(url, method: .get)
      .validate()
      .responseData { response in
        completion(response.result)
      }
  }
}


