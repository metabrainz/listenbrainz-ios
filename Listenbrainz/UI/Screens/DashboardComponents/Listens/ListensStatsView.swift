//
//  ListensStatsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import SwiftUI

struct ListensStatsView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userSelection:UserSelection
    @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""
    @State private var showingFollowersView = false
    @State private var showingFollowingView = false

    var body: some View {
        VStack {
            Text("You have listened to")
                .font(.headline)
            Text("\(dashboardViewModel.listenCount)")
                .font(.largeTitle)
                .bold()
            Text("songs so far")
                .font(.subheadline)

            Divider()

            HStack {
                VStack {
                    Text("\(dashboardViewModel.followers.count)")
                        .font(.title)
                        .bold()
                    Text("Followers")
                        .font(.subheadline)
                }
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .onTapGesture {
                    showingFollowersView = true
                }
                .sheet(isPresented: $showingFollowersView) {
                    FollowersView().environmentObject(dashboardViewModel)
                }

                VStack {
                    Text("\(dashboardViewModel.following.count)")
                        .font(.title)
                        .bold()
                    Text("Following")
                        .font(.subheadline)
                }
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .onTapGesture {
                    showingFollowingView = true
                }
                .sheet(isPresented: $showingFollowingView) {
                    FollowingView().environmentObject(dashboardViewModel)
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(colorScheme == .dark ? Color(.systemBackground).opacity(0.1) : Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}


struct FollowersView: View {
  @EnvironmentObject var dashboardViewModel: DashboardViewModel
  @EnvironmentObject var userSelection: UserSelection
  @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""

    var body: some View {
        VStack {
          Text("Followers")
            .font(.title)
            .fontWeight(.bold)
          Divider()
            ScrollView {
                ForEach(dashboardViewModel.followers, id: \.self) { follower in
                    FollowerRow(follower: follower)
                        .padding(.bottom, 8)
                }
            }
        }
        .padding()
        .onAppear {
            dashboardViewModel.getFollowers(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
        }
    }
}

struct FollowingView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel
  @EnvironmentObject var userSelection: UserSelection
  @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""

    var body: some View {
        VStack {
          Text("Following")
            .font(.title)
            .fontWeight(.bold)
          Divider()
            ScrollView {
                ForEach(dashboardViewModel.following, id: \.self) { following in
                    FollowerRow(follower: following)
                        .padding(.bottom, 8)
                }
            }
        }
        .padding()
        .onAppear {
            dashboardViewModel.getFollowing(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
        }
    }
}

struct FollowerRow: View {
    let follower: String

    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.trailing, 4)
            Text(follower)
                .font(.headline)
                .foregroundColor(Color.LbPurple)
            Spacer()
        }
        .padding()
        .cornerRadius(8)
    }
}





