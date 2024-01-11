//
//  YimViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class YIMViewModel: ObservableObject {
    @Published var topArtists: [TopArtistElement] = []
    @Published var topGenres: [TopGenre] = []
//    @Published var totalListeningTime: Double = 0
    @Published var totalListenCount: Int = 0
    @Published var totalArtistsCount: Int = 0
    @Published var topRecordings: [TopRecording] = []
    @Published var mostListenedYear: [String: Int] = [:]
    @Published var listensPerDay: [ListensPerDay] = []
    @Published var topReleaseGroups: [TopReleaseGroup] = []
    @Published var newReleasesOfTopArtist: [NewReleasesOfTopArtist] = []
    @Published var userName: String = ""
  @Published var daysOfWeek: String = ""
  @Published var totalReleaseGroupCount: Int = 0
  @Published var topDiscoveries: TopDiscoveries?
  @Published var similarUsers: [String: Double] = [:]



  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    private var cancellables: Set<AnyCancellable> = []

    private let repository: YIMRepository

    init(repository: YIMRepository) {
        self.repository = repository
    }

    func fetchYIMData(userName: String) {
        repository.fetchYIMData(userName: userName)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching YIM data: \(error.localizedDescription)")
                }
            } receiveValue: { data in
              self.topArtists = data.payload.data.topArtists
                self.topGenres = data.payload.data.topGenres
//                self.totalListeningTime = data.payload.data.totalListeningTime
                self.totalListenCount = data.payload.data.totalListenCount
                self.totalArtistsCount = data.payload.data.totalArtistsCount
                self.topRecordings = data.payload.data.topRecordings
                self.mostListenedYear = data.payload.data.mostListenedYear
                self.listensPerDay = data.payload.data.listensPerDay
                self.topReleaseGroups = data.payload.data.topReleaseGroups
                self.newReleasesOfTopArtist = data.payload.data.newReleasesOfTopArtists
                self.userName = data.payload.userName
              self.daysOfWeek = data.payload.data.dayOfWeek
              self.totalReleaseGroupCount = data.payload.data.totalReleaseGroupsCount
              self.topDiscoveries = data.payload.data.topDiscoveries
              self.similarUsers = data.payload.data.similarUsers


                if let firstReleaseGroup = self.topReleaseGroups.first,
                   let caaReleaseMbid = firstReleaseGroup.caaReleaseMbid,
                   let caaID = firstReleaseGroup.caaID,
                   let coverArtURL = URL(string: "https://coverartarchive.org/release/\(caaReleaseMbid)/\(caaID)-250.jpg") {
                    self.fetchCoverArt(url: coverArtURL) { result in
                        switch result {
                        case .success(_):
                            print("Cover art fetched successfully")
                        case .failure(let error):
                            print("Error fetching cover art: \(error)")
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }

    private func fetchCoverArt(url: URL, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                completion(response.result)
            }
    }
}
