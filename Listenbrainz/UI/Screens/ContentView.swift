//
//  ContentView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 16/04/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    init() {
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            VStack(spacing: 0) {
                PlayerView()
                    .edgesIgnoringSafeArea(.all)
                
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6, alignment: .center)
            }
            .tabItem {
                
                
                Label("Player", systemImage: "opticaldisc.fill")
            }
            ListensView()
                .tabItem {
                    Label("Listen", systemImage: "person.wave.2")
                }
            VStack(spacing: 0) {
                ProfileView()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6, alignment: .center)
            }
            .tabItem {
                
                Label("Profile", systemImage: "beats.headphones")
            }
            
        }
        .accentColor(Color.gray)
    }
    
}

