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
    VStack{

      TopBar(isSettingsPressed:$isSettingsPressed)


      List {
        ForEach(viewModel.events, id: \.id) { event in
          VStack(alignment: .leading){
            HStack(spacing: 20) {
              EventImageView(eventType: event.eventType)
                .frame(width: 18, height: 18)
              EventDescriptionView(event: event)

            }
            if event.eventType != "follow"{
              TrackInfoView(event: event)
            }

          }

        }
      }
      .sheet(isPresented: $isSettingsPressed) {
        SettingsView()
      }
      .listStyle(PlainListStyle())
      .listRowSeparator(.hidden)
      .listRowInsets(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 16))
    }
  }
}


