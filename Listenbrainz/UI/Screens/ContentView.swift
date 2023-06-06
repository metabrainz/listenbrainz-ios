//
//  ContentView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
 
  let screenWidth = UIScreen.main.bounds.size.width
  let screenHeight = UIScreen.main.bounds.size.height
  
  init() {
    UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
    UITabBar.appearance().clipsToBounds = true
  }
  
  var body: some View {
    ZStack{
      TabView {
        HomeView()
          .tabItem {
            Label("Home", systemImage: "house.fill")
          }
        PlayerView()
          .edgesIgnoringSafeArea(.all)
        
          .frame(width: screenWidth, height: screenHeight, alignment: .center)
        
          .tabItem {
            
            
            Label("Player", systemImage: "opticaldisc.fill")
          }

        ListensView()
          .frame(width: screenWidth, height: screenHeight, alignment: .center)

      
          .tabItem {
            Label("Listens", systemImage: "person.wave.2")
          }
        
        ProfileView()
          .frame(width: screenWidth, height: screenHeight, alignment: .center)
        
          .tabItem {
            
            Label("Profile", systemImage: "beats.headphones")
          }
        
      }
      .accentColor(Color.gray)
    }
  }
}
