//
//  FeedView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 30/08/23.
//

import SwiftUI

struct FeedView: View {
  @EnvironmentObject var viewModel: FeedViewModel

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.events, id: \.id) { event in
          VStack(alignment: .leading){
            HStack(spacing: 20) {
              EventImageView(eventType: event.eventType)
                .frame(width: 18, height: 18)
              EventDescriptionView(event: event)

            }

            TrackInfoView(event: event)


          }

        }
      }
      .background(Color.orange.opacity(0.8))
      .listStyle(PlainListStyle())
      .listRowSeparator(.hidden)
      .listRowInsets(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 16))

//      .onAppear {
//        viewModel.fetchFeedEvents(username: "gb1307")
//      }
      .navigationTitle("Feed")
    }
  }
}

