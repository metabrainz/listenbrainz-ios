//
//  HomeRepository.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 29/05/23.
//



import Foundation
import Combine
import Alamofire

protocol HomeRepository {


  func fetchMusicData(userName:String,page:Int,perPage:Int) -> AnyPublisher<Listens, AFError>
}
