//
//  APICall.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 10/05/23.
//

import SwiftUI
import UIKit

let user_name = "userName"

func getData(){

  let session = URLSession.shared
  let serviceUrl = URL(string: "https://api.listenbrainz.org/1/user/(user_name)/listens")

  let task = session.dataTask(with: serviceUrl!){ (serviceData, serverResponse, error) in

    if (error == nil){

      let httpResponse = serverResponse as! HTTPURLResponse


        let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
        print(jsonData)
      


    }



  }
  task.resume()

}
