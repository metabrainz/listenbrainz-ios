// ContentView.swift
import SwiftUI
import Combine

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var feedViewModel: FeedViewModel
    @StateObject var yimViewModel = YIMViewModel(repository: YIMRepositoryImpl())
    @EnvironmentObject var dashboardViewModel:DashboardViewModel
    @EnvironmentObject var userSelection: UserSelection

    init() {
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
    }

    var body: some View {
        ZStack {
            TabView {
                FeedView()
                    .environmentObject(feedViewModel)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Feed", systemImage: "bolt")
                    }

                ExploreView(viewModel: yimViewModel)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Explore", systemImage: "safari")
                    }

                PlayerView()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Player", systemImage: "headphones")
                    }

                ListensView()
                    .environmentObject(homeViewModel)
                    .environmentObject(dashboardViewModel)
                    .environmentObject(userSelection)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Listens", systemImage: "person.wave.2")
                    }
            }
            .accentColor(Color.gray)
        }
    }
}

