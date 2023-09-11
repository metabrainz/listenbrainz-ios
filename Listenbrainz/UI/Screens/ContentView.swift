//
//  ContentView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
  @State private var userName:String = ""
  let screenWidth = UIScreen.main.bounds.size.width
  let screenHeight = UIScreen.main.bounds.size.height
  @EnvironmentObject var homeViewModel: HomeViewModel
  @EnvironmentObject var feedViewModel: FeedViewModel
  
  
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
          .environmentObject(homeViewModel)
          .frame(width: screenWidth, height: screenHeight, alignment: .center)
          .tabItem {
            Label("Listens", systemImage: "person.wave.2")
          }
        
        FeedView()
          .environmentObject(feedViewModel)
          .frame(width: screenWidth, height: screenHeight, alignment: .center)
          .tabItem {
            Label("Feed", systemImage: "bolt")
          }
      }
      .accentColor(Color.gray)
    }
  }
}
