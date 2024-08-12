//
//  ContentView.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 19/03/23.
//

import SwiftUI

struct ListensView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var dashboardViewModel = DashboardViewModel(repository: DashboardRepositoryImpl())
    @State private var selectedTab = 0
    @State private var isSettingsPressed = false
    @State private var isSearchActive = false
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

    var body: some View {
            ZStack {
                colorScheme == .dark ? Color.backgroundColor : Color.white
                VStack {
                    TopBar(isSettingsPressed: $isSettingsPressed, isSearchActive: $isSearchActive, customText: "Listens")

                    ScrollView(.horizontal, showsIndicators: false) {
                      HStack {
                        TabButton(title: "Listens", isSelected: selectedTab == 0) {
                          selectedTab = 0
                        }
                        TabButton(title: "Stats", isSelected: selectedTab == 1) {
                          selectedTab = 1
                        }
                        TabButton(title: "Taste", isSelected: selectedTab == 2) {
                          selectedTab = 2
                        }
                        TabButton(title: "Playlists", isSelected: selectedTab == 3) {
                          selectedTab = 3
                        }
                        TabButton(title: "Created for you", isSelected: selectedTab == 4) {
                          selectedTab = 4
                        }
                      }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }

                    Spacer()


                  if selectedTab == 0 {
                    ScrollView {
                      VStack {
                        ListensStatsView()
                          .environmentObject(dashboardViewModel)

                        SongDetailView()
                          .frame(maxWidth: .infinity, alignment: .leading)
                          .background(colorScheme == .dark ? Color.black : Color.white)
                          .cornerRadius(10)
                          .shadow(radius: 2)
                          .sheet(isPresented: $isSettingsPressed) {
                            SettingsView()
                          }
                      }
                    }
                  }else if selectedTab == 1 {
                    StatisticsView(viewModel: dashboardViewModel)
                    }
                    Spacer()
                }
            }
            .onAppear {
                homeViewModel.requestMusicData(userName: userName)
                dashboardViewModel.userName = userName
                dashboardViewModel.getListenCount(username: userName)
                dashboardViewModel.getFollowers(username: userName)
                dashboardViewModel.getFollowing(username: userName)
            }
        }
    }


struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .foregroundColor(isSelected ? .white : .black)
                .background(isSelected ? Color.secondary : Color.clear)
                .clipShape(Rectangle())
        }
        .frame(maxWidth: .infinity)
    }
}




