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
                NavigationLink(destination: FollowersView().environmentObject(dashboardViewModel)) {
                    VStack {
                        Text("\(dashboardViewModel.followers.count)")
                            .font(.title)
                            .bold()
                        Text("Followers")
                            .font(.subheadline)
                    }
                }

                NavigationLink(destination: FollowingView().environmentObject(dashboardViewModel)) {
                    VStack {
                        Text("\(dashboardViewModel.following.count)")
                            .font(.title)
                            .bold()
                        Text("Following")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}


struct FollowersView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel

    var body: some View {
        VStack {
            List(dashboardViewModel.followers, id: \.self) { follower in
                Text(follower)
            }
        }
        .navigationTitle("Followers")
        .onAppear {
            dashboardViewModel.getFollowers(username: dashboardViewModel.userName)
        }
    }
}

struct FollowingView: View {
    @EnvironmentObject var dashboardViewModel: DashboardViewModel

    var body: some View {
        VStack {
            List(dashboardViewModel.following, id: \.self) { following in
                Text(following)
            }
        }
        .navigationTitle("Following")
        .onAppear {
            dashboardViewModel.getFollowing(username: dashboardViewModel.userName)
        }
    }
}





