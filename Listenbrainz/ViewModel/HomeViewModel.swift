//
//  HomeViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//

import Foundation
import Combine


class HomeViewModel : ObservableObject {

    @Published var listens: [Listen] = []


    private var subscriptions: Set<AnyCancellable> = []

    var repository: HomeRepository


    init(repository: HomeRepository) {
        self.repository = repository

    }



  func requestMusicData(userName:String) {
      repository.fetchMusicData(userName: userName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { value in
              self.listens = value.payload.listens
            })
            .store(in: &subscriptions)
    }
}



