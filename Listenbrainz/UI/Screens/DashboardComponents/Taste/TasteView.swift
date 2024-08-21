//
//  TasteView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import SwiftUI

struct TasteView: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    @EnvironmentObject var userSelection: UserSelection
    @State private var showPinTrackView = false
    @State private var showWriteReview = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var selectedTaste: Taste?
    @State private var selectedPinnedRecording: PinnedRecording?
    @State private var isPresented: Bool = false
    @State private var selectedCategory: SongCategory = .loved

    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack {
                    CapsuleBarView(title: "Loved", isSelected: selectedCategory == .loved, imageName: "heart")
                        .onTapGesture {
                            selectedCategory = .loved
                        }
                    CapsuleBarView(title: "Hated", isSelected: selectedCategory == .hated, imageName: "broken-heart")
                        .onTapGesture {
                            selectedCategory = .hated
                        }
                }
                .padding(.top)
                .padding(.trailing, 140)

                ScrollView {
                    LazyVStack {
                        if selectedCategory == .loved {
                            ForEach(viewModel.lovedTastes, id: \.id) { taste in
                                TrackInfoView(item: taste, onPinTrack: { taste in
                                    selectedTaste = taste
                                    showPinTrackView = true
                                }, onRecommendPersonally: { taste in
                                    selectedTaste = taste
                                    showingRecommendToUsersPersonallyView = true
                                }, onWriteReview: { taste in
                                    selectedTaste = taste
                                    showWriteReview = true
                                })
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            }
                        } else {
                            ForEach(viewModel.hatedTastes, id: \.id) { taste in
                                TrackInfoView(item: taste, onPinTrack: { taste in
                                    selectedTaste = taste
                                    showPinTrackView = true
                                }, onRecommendPersonally: { taste in
                                    selectedTaste = taste
                                    showingRecommendToUsersPersonallyView = true
                                }, onWriteReview: { taste in
                                    selectedTaste = taste
                                    showWriteReview = true
                                })
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
                PinsView(
                    selectedPinnedRecording: $selectedPinnedRecording,
                    showPinTrackView: $showPinTrackView,
                    showingRecommendToUsersPersonallyView: $showingRecommendToUsersPersonallyView,
                    showWriteReview: $showWriteReview
                )
                .environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.getTaste(userName: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
        }
        .centeredModal(isPresented: $showPinTrackView) {
            if let taste = selectedTaste {
                PinTrackView(
                    isPresented: $isPresented,
                    item: taste,
                    userToken: userToken,
                    dismissAction: {
                        showPinTrackView = false
                    }
                )
                .environmentObject(viewModel)
            } else if let pinnedRecording = selectedPinnedRecording {
                PinTrackView(
                    isPresented: $isPresented,
                    item: pinnedRecording,
                    userToken: userToken,
                    dismissAction: {
                        showPinTrackView = false
                    }
                )
                .environmentObject(viewModel)
            }
        }
        .centeredModal(isPresented: $showingRecommendToUsersPersonallyView) {
            if let taste = selectedTaste {
                RecommendToUsersPersonallyView(item: taste, userName: storedUserName, userToken: userToken, dismissAction: {
                    showingRecommendToUsersPersonallyView = false
                })
                .environmentObject(viewModel)
            } else if let pinnedRecording = selectedPinnedRecording {
                RecommendToUsersPersonallyView(item: pinnedRecording, userName: storedUserName, userToken: userToken, dismissAction: {
                    showingRecommendToUsersPersonallyView = false
                })
                .environmentObject(viewModel)
            }
        }
        .centeredModal(isPresented: $showWriteReview) {
            if let taste = selectedTaste {
                WriteAReviewView(isPresented: $showWriteReview, item: taste, userToken: userToken, userName: storedUserName) {
                    showWriteReview = false
                }
                .environmentObject(viewModel)
            } else if let pinnedRecording = selectedPinnedRecording {
                WriteAReviewView(isPresented: $showWriteReview, item: pinnedRecording, userToken: userToken, userName: storedUserName) {
                    showWriteReview = false
                }
                .environmentObject(viewModel)
            }
        }
    }
}





