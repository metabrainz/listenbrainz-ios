// ContentView.swift
import SwiftUI


struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var feedViewModel: FeedViewModel
    @StateObject var yimViewModel: YIMViewModel

    init() {
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
      _yimViewModel = StateObject(wrappedValue: YIMViewModel(repository: YIMRepositoryImpl()))
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
              PlayerView(viewModel: yimViewModel)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Explore", systemImage: "safari")
                    }

                ListensView()
                    .environmentObject(homeViewModel)
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    .tabItem {
                        Label("Listens", systemImage: "person.wave.2")
                    }
            }
            .accentColor(Color.gray)
        }
    }
}


