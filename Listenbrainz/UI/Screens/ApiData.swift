//
//  ApiData.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 05/05/23.
//

import Foundation

struct Post:Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}
