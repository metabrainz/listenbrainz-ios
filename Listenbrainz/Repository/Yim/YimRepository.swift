//
//  YimRepository.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Combine
import SwiftUI
import Alamofire

protocol YIMRepository {
    func fetchYIMData(userName:String) -> AnyPublisher<YIMData, Error>
}
