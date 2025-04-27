//
//  PinsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/08/24.
//

import SwiftUI


struct PinsView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    @Binding var selectedPinnedRecording: PinnedRecording?
    @Binding var showPinTrackView: Bool
    @Binding var showingRecommendToUsersPersonallyView: Bool
    @Binding var showWriteReview: Bool
    @EnvironmentObject var theme: Theme
    
    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    
    var body: some View {
        LazyVStack {
            HStack {
                Text("Your Pins")
                    .font(.title2)
                    .padding(.top)
                    .padding(.leading)
                Spacer()
            }
            
            ForEach(viewModel.pinnedRecordings, id: \.id) { pinnedRecording in
                ListenCardView(item: pinnedRecording, onPinTrack: { recording in
                    selectedPinnedRecording = recording
                    showPinTrackView = true
                }, onRecommendPersonally: { recording in
                    selectedPinnedRecording = recording
                    showingRecommendToUsersPersonallyView = true
                }, onWriteReview: { recording in
                    selectedPinnedRecording = recording
                    showWriteReview = true
                })
                .frame(width:  UIScreen.main.bounds.width * 0.9, alignment: .leading)
            }
        }
        .onAppear {
            viewModel.getPinTrack(userName: userName)
        }
    }
}
