//
//  ImageLoader.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/12/23.
//

import SwiftUI
import Combine
import Alamofire


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
