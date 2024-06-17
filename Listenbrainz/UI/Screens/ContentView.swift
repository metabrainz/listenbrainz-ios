// ContentView.swift
import SwiftUI
import Combine

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var feedViewModel: FeedViewModel
    @StateObject var yimViewModel = YIMViewModel(repository: YIMRepositoryImpl())
    @State private var keyboardHeight: CGFloat = 0

    init() {
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
    }

    var body: some View {
        ZStack {
            TabView {
                FeedView()
                    .environmentObject(feedViewModel)
                    .frame(width: screenWidth, height: screenHeight - keyboardHeight, alignment: .center)
                    .tabItem {
                        Label("Feed", systemImage: "bolt")
                    }

                ExploreView(viewModel: yimViewModel)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: screenWidth, height: screenHeight - keyboardHeight, alignment: .center)
                    .tabItem {
                        Label("Explore", systemImage: "safari")
                    }

                PlayerView()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: screenWidth, height: screenHeight - keyboardHeight, alignment: .center)
                    .tabItem {
                        Label("Player", systemImage: "headphones")
                    }

                ListensView()
                    .environmentObject(homeViewModel)
                    .frame(width: screenWidth, height: screenHeight - keyboardHeight, alignment: .center)
                    .tabItem {
                        Label("Listens", systemImage: "person.wave.2")
                    }
            }
            .accentColor(Color.gray)
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardFrame.height
                }
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                keyboardHeight = 0
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
}

