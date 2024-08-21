//
//  ContentView.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 19/03/23.
//

import SwiftUI

struct ListensView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var userSelection: UserSelection
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @State private var selectedTab = 0
    @State private var isSettingsPressed = false
    @State private var isSearchActive = false
    @State private var showPinTrackView = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var showWriteReview = false
    @State private var selectedListen: Listen?
    @State private var isPresented: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""

    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.backgroundColor : Color.white
            VStack {
                TopBar(isSettingsPressed: $isSettingsPressed, isSearchActive: $isSearchActive, customText: topBarTitle)

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
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

                if selectedTab == 0 {
                    ScrollView {
                        VStack {
                          Text(userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
                            ListensStatsView()
                                .environmentObject(dashboardViewModel)
                            LazyVStack {
                                ForEach(homeViewModel.listens, id: \.uuid) { listen in
                                    TrackInfoView(
                                        item: listen,
                                        onPinTrack: { event in
                                            selectedListen = listen
                                            showPinTrackView = true
                                        },
                                        onRecommendPersonally: { event in
                                            selectedListen = listen
                                            showingRecommendToUsersPersonallyView = true
                                        },
                                        onWriteReview: { event in
                                            selectedListen = listen
                                            showWriteReview = true
                                        }
                                    )
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(colorScheme == .dark ? Color(.systemBackground).opacity(0.1) : Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                    .onAppear {
                                        if listen == homeViewModel.listens.last && homeViewModel.canLoadMorePages {
                                            Task {
                                                do {
                                                    try await homeViewModel.fetchMusicData(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
                                                } catch {
                                                    print("Error fetching more listens: \(error)")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if homeViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding(.vertical, 10)
                        }
                    }
                    .refreshable {
                        await refreshListens()
                    }
                } else if selectedTab == 1 {
                    StatisticsView()
                        .environmentObject(dashboardViewModel)
                        .environmentObject(userSelection)
                } else if selectedTab == 2 {
                    TasteView()
                        .environmentObject(dashboardViewModel)
                        .environmentObject(userSelection)
                } else if selectedTab == 3 {
                    PlaylistView()
                        .environmentObject(dashboardViewModel)
                        .environmentObject(userSelection)
                } else {
                    CreatedForYouView()
                        .environmentObject(dashboardViewModel)
                        .environmentObject(userSelection)
                }
                Spacer()
            }
            .sheet(isPresented: $isSettingsPressed) {
                SettingsView()
            }
            .centeredModal(isPresented: $showPinTrackView) {
                if let listen = selectedListen {
                    PinTrackView(
                        isPresented: $showPinTrackView,
                        item: listen,
                        userToken: userToken,
                        dismissAction: {
                            showPinTrackView = false
                        }
                    )
                    .environmentObject(homeViewModel)
                }
            }
            .centeredModal(isPresented: $showingRecommendToUsersPersonallyView) {
                if let listen = selectedListen {
                    RecommendToUsersPersonallyView(item: listen, userName: userSelection.selectedUserName, userToken: userToken, dismissAction: {
                        showingRecommendToUsersPersonallyView = false
                    })
                    .environmentObject(homeViewModel)
                }
            }
            .centeredModal(isPresented: $showWriteReview) {
                if let listen = selectedListen {
                    WriteAReviewView(isPresented: $showWriteReview, item: listen, userToken: userToken, userName: userSelection.selectedUserName) {
                        showWriteReview = false
                    }
                    .environmentObject(homeViewModel)
                }
            }
        }
        .onAppear {
          fetchData(for: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
        }
        .onChange(of: userSelection.selectedUserName) { newUserName in
            if !newUserName.isEmpty {
                fetchData(for: newUserName)
            }
        }
    }

    private func refreshListens() async {
        do {
            homeViewModel.resetPagination()
            try await homeViewModel.fetchMusicData(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
        } catch {
            print("Error refreshing listens: \(error)")
        }
    }

    private var topBarTitle: String {
        switch selectedTab {
        case 0: return "Listens"
        case 1: return "Statistics"
        case 2: return "Taste"
        case 3: return "Playlists"
        case 4: return "Created for You"
        default: return "Listens"
        }
    }

    private func fetchData(for username: String? = nil) {
        let nameToUse = username ?? (userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)

        if !nameToUse.isEmpty {
            Task {
                do {
                    homeViewModel.resetPagination()
                    try await homeViewModel.fetchMusicData(username: nameToUse)
                } catch {
                    print("Error fetching music data: \(error)")
                }
            }
            dashboardViewModel.userName = nameToUse
            dashboardViewModel.getListenCount(username: nameToUse)
            dashboardViewModel.getFollowers(username: nameToUse)
            dashboardViewModel.getFollowing(username: nameToUse)
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
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isSelected ? Rectangle().fill(Color.secondary) : Rectangle().fill(Color.gray.opacity(0.2)))
                .foregroundColor(isSelected ? .white : .black)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .frame(maxWidth: .infinity)
    }
}


