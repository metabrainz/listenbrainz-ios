//
//  SearchViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 03/06/24.
//

import Combine
import SwiftUI
import Alamofire

class SearchViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var users: [User] = []
    @Published var isActive: Bool = false
    @Published var error: String? = nil

    private var cancellable: AnyCancellable?
    private var subscriptions: Set<AnyCancellable> = []
    private var repository: SearchRepository

    init(repository: SearchRepository) {
        self.repository = repository

        cancellable = $searchTerm
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] term in
                self?.searchUsers(term: term)
            }
    }

    func searchUsers(term: String) {
        guard !term.isEmpty else {
            self.users = []
            return
        }

        repository.searchUsers(term: term)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.error = nil
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }, receiveValue: { response in
                self.users = response.users
            })
            .store(in: &subscriptions)
    }

    func clearSearch() {
        self.searchTerm = ""
        self.users = []
        self.error = nil
    }
}


