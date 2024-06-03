//
//  SearchViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 03/06/24.
//

import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var users: [User] = []
    @Published var isActive: Bool = false
    @Published var error: String? = nil

    private var cancellable: AnyCancellable?

    init() {
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

        let urlString = "\(BuildConfiguration.shared.API_LISTENBRAINZ_BASE_URL)/search/users?search_term=\(term)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                print("Received Data: \(String(data: data, encoding: .utf8) ?? "No Data")")
                do {
                    let decodedResponse = try JSONDecoder().decode(UserSearchResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.users = decodedResponse.users
                        self.error = nil
                    }
                } catch {
                    print("Decoding Error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.error = "Failed to decode response: \(error.localizedDescription)"
                    }
                }
            } else if let error = error {
                print("Network Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                }
            }
        }
        .resume()
    }

    func clearSearch() {
        self.searchTerm = ""
        self.users = []
        self.error = nil
    }
}

