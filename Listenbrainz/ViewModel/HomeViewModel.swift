//
//  HomeViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import Foundation
import Combine
import Alamofire

class HomeViewModel: ObservableObject {
    @Published var listens: [Listen] = []
    @Published var isLoading: Bool = false
    @Published var isInitialLoad = true
    @Published var canLoadMorePages: Bool = true

    private var currentPage: Int = 1
    private let itemsPerPage: Int = 25
    private var subscriptions: Set<AnyCancellable> = []
    private let subscriptionLimit = 10  // Limit the number of active subscriptions

    var repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func fetchMusicData(username: String) async throws {
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
            repository.fetchMusicData(userName: username, page: currentPage, perPage: itemsPerPage)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }, receiveValue: { data in
                    let newListens = data.payload.listens
                    if newListens.isEmpty {
                        self.canLoadMorePages = false
                    } else {
                        self.currentPage += 1
                        self.listens.append(contentsOf: newListens)
                    }
                })
                .store(in: &self.subscriptions)

            
            if self.subscriptions.count > self.subscriptionLimit {
                // Convert to an array, drop the excess, and convert back to a set
                self.subscriptions = Set(self.subscriptions.suffix(self.subscriptionLimit))
            }
        }
    }

    func resetPagination() {
        currentPage = 1
        canLoadMorePages = true
        listens.removeAll()
        subscriptions.removeAll()
    }

    private func fetchCoverArt(url: URL, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                completion(response.result)
            }
    }
}



