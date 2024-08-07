//
//  DashboardViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/07/24.
//

import Foundation
import Combine
import Alamofire

class DashboardViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var listenCount: Int = 0
    @Published var error: String? = nil
    @Published var followers: [String] = []
    @Published var following: [String] = []

    private var subscriptions: Set<AnyCancellable> = []
    private var repository: DashboardRepository

    init(repository: DashboardRepository) {
        self.repository = repository
    }

    func getListenCount(username: String) {
        print("Fetching listen count for username: \(username)")
        guard !username.isEmpty else {
            self.listenCount = 0
            return
        }

        repository.getListenCount(userName: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = nil
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("Error fetching listen count: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] countPayload in
                print("Received count payload: \(countPayload)")
                self?.listenCount = countPayload.count
            })
            .store(in: &subscriptions)
    }

  func getFollowers(username: String) {
         print("Fetching followers for username: \(username)")
         guard !username.isEmpty else {
             self.followers = []
             return
         }

         repository.getFollowers(userName: username)
             .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { [weak self] completion in
                 switch completion {
                 case .finished:
                     self?.error = nil
                 case .failure(let error):
                     self?.error = error.localizedDescription
                     print("Error fetching followers: \(error.localizedDescription)")
                 }
             }, receiveValue: { [weak self] followers in
                 print("Received followers: \(followers)")
                 self?.followers = followers.followers ?? []
             })
             .store(in: &subscriptions)
     }

  func getFollowing(username: String) {
          print("Fetching following for username: \(username)")
          guard !username.isEmpty else {
              self.following = []
              return
          }

          repository.getFollowing(userName: username)
              .receive(on: DispatchQueue.main)
              .sink(receiveCompletion: { [weak self] completion in
                  switch completion {
                  case .finished:
                      self?.error = nil
                  case .failure(let error):
                      self?.error = error.localizedDescription
                      print("Error fetching following: \(error.localizedDescription)")
                  }
              }, receiveValue: { [weak self] following in
                  print("Received following: \(following)")
                  self?.following = following.following ?? []
              })
              .store(in: &subscriptions)
      }
}


