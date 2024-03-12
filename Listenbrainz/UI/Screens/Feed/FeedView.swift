//
//  FeedView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//


import SwiftUI

struct FeedView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @State private var isSettingsPressed = false

    var body: some View {

        ZStack {
            Color(red: 0.16, green: 0.16, blue: 0.16)

            VStack {

                TopBar(isSettingsPressed: $isSettingsPressed, customText: "Feed")

                ScrollView {
                    ForEach(viewModel.events, id: \.id) { event in
                        HStack(alignment: .top, spacing: 10) {

                            VStack(alignment: .leading) {
                                EventImageView(eventType: event.eventType)
                                    .frame(width: 22, height: 22)
                                VerticalLine()
                                    .frame(width: 1, height: event.eventType == "follow" ? 15 : 60)
                                    .background(Color.white)
                                    .offset(x: 10, y: 4)
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                EventDescriptionView(event: event)
                                if event.eventType != "follow" {
                                    TrackInfoView(event: event)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        .shadow(radius: 2)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                }
                .sheet(isPresented: $isSettingsPressed) {
                    SettingsView()
                }
            }
        }
    }
}

struct VerticalLine: View {
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 1)
    }
}

