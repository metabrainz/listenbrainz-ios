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

class ImageCache {
  static let shared = ImageCache()

  private let cache = NSCache<NSURL, UIImage>()

  func image(for url: URL) -> UIImage? {
    return cache.object(forKey: url as NSURL)
  }

  func insertImage(_ image: UIImage, for url: URL) {
    cache.setObject(image, forKey: url as NSURL)
  }
}

class ImageLoader: ObservableObject {
  static let shared = ImageLoader()

  private var cancellables: Set<AnyCancellable> = []

  @Published var imageCache: [URL: UIImage] = [:]

  func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
    if let cachedImage = imageCache[url] {
      completion(cachedImage)
      return
    }

    AF.request(url).responseData { response in
      switch response.result {
      case .success(let data):
        if let uiImage = UIImage(data: data) {
          self.imageCache[url] = uiImage
          completion(uiImage)
        } else {
          completion(nil)
        }
      case .failure:
        completion(nil)
      }
    }
  }
}
