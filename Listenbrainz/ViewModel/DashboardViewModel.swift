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
    @Published var listeningActivity: [ListeningActivity] = []
    @Published var topArtists: [ArtistElement] = []
    @Published var topAlbums: [Release] = []
    @Published var topTracks: [Recording] = []
    @Published var dailyActivities: [String: [Day]] = [:]
     @Published var hours: [Int] = []
     @Published var counts: [Int] = []

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


    func getListeningActivity(username: String) {
        print("Fetching listening activity for username: \(username)")
        guard !username.isEmpty else {
            self.listeningActivity = []
            return
        }

        repository.getListeningActivity(userName: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = nil
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("Error fetching listening activity: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] payload in
                print("Received listening activity payload: \(payload)")
                self?.listeningActivity = payload.listeningActivity
            })
            .store(in: &subscriptions)
    }


    func getTopArtists(username: String) {
        print("Fetching top artists for username: \(username)")
        guard !username.isEmpty else {
            self.topArtists = []
            return
        }

        repository.getTopArtists(userName: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = nil
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("Error fetching top artists: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] payload in
                print("Received top artists payload: \(payload)")
                self?.topArtists = payload.artists
            })
            .store(in: &subscriptions)
    }


    func getTopAlbums(username: String) {
        print("Fetching top albums for username: \(username)")
        guard !username.isEmpty else {
            self.topAlbums = []
            return
        }

        repository.getTopAlbums(userName: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = nil
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("Error fetching top albums: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] payload in
                print("Received top albums payload: \(payload)")
                self?.topAlbums = payload.releases
            })
            .store(in: &subscriptions)
    }

    func getTopTracks(username: String) {
        print("Fetching top tracks for username: \(username)")
        guard !username.isEmpty else {
            self.topTracks = []
            return
        }

        repository.getTopTracks(userName: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.error = nil
                case .failure(let error):
                    self?.error = error.localizedDescription
                    print("Error fetching top tracks: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] payload in
                print("Received top tracks payload: \(payload)")
                self?.topTracks = payload.recordings
            })
            .store(in: &subscriptions)
    }

  func getDailyActivity(username: String) {
         print("Fetching daily activity for username: \(username)")
         guard !username.isEmpty else {
             self.dailyActivities = [:]
             return
         }

         repository.getDailyActivity(userName: username)
             .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { [weak self] completion in
                 switch completion {
                 case .finished:
                     self?.error = nil
                 case .failure(let error):
                     self?.error = error.localizedDescription
                     print("Error fetching daily activity: \(error.localizedDescription)")
                 }
             }, receiveValue: { [weak self] payload in
                 print("Received daily activity payload: \(payload)")
                 self?.dailyActivities = [
                     "Monday": payload.dailyActivity.monday,
                     "Tuesday": payload.dailyActivity.tuesday,
                     "Wednesday": payload.dailyActivity.wednesday,
                     "Thursday": payload.dailyActivity.thursday,
                     "Friday": payload.dailyActivity.friday,
                     "Saturday": payload.dailyActivity.saturday,
                     "Sunday": payload.dailyActivity.sunday
                 ]
                 self?.parseDailyActivity()
             })
             .store(in: &subscriptions)
     }

     private func parseDailyActivity() {
         var allHours: [Int] = []
         var allCounts: [Int] = []

         for (_, days) in dailyActivities {
             for day in days {
                 allHours.append(day.hour)
                 allCounts.append(day.listenCount)
             }
         }

         self.hours = allHours
         self.counts = allCounts
     }
}



