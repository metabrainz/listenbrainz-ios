// ContentView.swift
import SwiftUI
import Combine

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var feedViewModel: FeedViewModel
    @StateObject var yimViewModel = YIMViewModel(repository: YIMRepositoryImpl())
    @StateObject var insetsHolder: InsetsHolder = InsetsHolder()

    init() {
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
    }

    var body: some View {
        ZStack {
            TabView {
                FeedView()
                    .environmentObject(feedViewModel)
                    .environmentObject(insetsHolder)
                    .ignoresSafeArea()
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabBarAccessor({ UITabBar in
                        // Update tab bar height only here since rest of the tab bars will have same height.
                        DispatchQueue.main.async {
                            insetsHolder.tabBarHeight = UITabBar.bounds.height
                        }
                    })
                    .tabItem {
                        Label("Feed", systemImage: "bolt")
                    }

                ExploreView(viewModel: yimViewModel)
                    .environmentObject(insetsHolder)
                    .ignoresSafeArea()
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Explore", systemImage: "safari")
                    }

                PlayerView()
                    .environmentObject(insetsHolder)
                    .ignoresSafeArea()
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Player", systemImage: "headphones")
                    }

                ListensView()
                    .environmentObject(homeViewModel)
                    .environmentObject(insetsHolder)
                    .ignoresSafeArea()
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Listens", systemImage: "person.wave.2")
                    }
            }
            .accentColor(Color.blue)
        }
    }
}

