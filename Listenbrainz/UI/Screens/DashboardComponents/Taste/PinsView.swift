//
//  PinsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import SwiftUI


struct PinsView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
  @EnvironmentObject var userSelection:UserSelection
    @Binding var selectedPinnedRecording: PinnedRecording?
    @Binding var showPinTrackView: Bool
    @Binding var showingRecommendToUsersPersonallyView: Bool
    @Binding var showWriteReview: Bool

    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""

    var body: some View {
        VStack {
            HStack {
                Text("Your Pins")
                    .font(.headline)
                    .padding(.top)
                    .padding(.leading)
                Spacer()
            }
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.pinnedRecordings, id: \.id) { pinnedRecording in
                        TrackInfoView(item: pinnedRecording, onPinTrack: { recording in
                            selectedPinnedRecording = recording
                            showPinTrackView = true
                        }, onRecommendPersonally: { recording in
                            selectedPinnedRecording = recording
                            showingRecommendToUsersPersonallyView = true
                        }, onWriteReview: { recording in
                            selectedPinnedRecording = recording
                            showWriteReview = true
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getPinTrack(userName: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
        }
    }
}
