//
//  TasteView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import SwiftUI

struct TasteView: View {
    @EnvironmentObject var insetsHolder: InsetsHolder
    @EnvironmentObject var viewModel: DashboardViewModel
    @EnvironmentObject var theme: Theme
    @State private var showPinTrackView = false
    @State private var showWriteReview = false
    @State private var showingRecommendToUsersPersonallyView = false
    @State private var selectedTaste: Taste?
    @State private var selectedPinnedRecording: PinnedRecording?
    @State private var isPresented: Bool = false
    @State private var selectedCategory: SongCategory = .loved
    @Environment(\.colorScheme) var colorScheme

    @AppStorage(Strings.AppStorageKeys.userToken) private var userToken: String = ""
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""

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
                                .frame(width:  UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                .background(theme.colorScheme.level1)
                                .cornerRadius(theme.sizes.cornerRadius)
                                .shadow(radius: theme.sizes.shadowRadius)
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
                                .frame(width:  UIScreen.main.bounds.width * 0.9, alignment: .leading)
                                .background(theme.colorScheme.level1)
                                .cornerRadius(theme.sizes.cornerRadius)
                                .shadow(radius: theme.sizes.shadowRadius)
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
            
            Spacer(minLength: theme.spacings.screenBottom)
        }
        .padding(.bottom, insetsHolder.tabBarHeight)
        .onAppear {
            viewModel.getTaste(userName: userName)
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
                RecommendToUsersPersonallyView(item: taste, userName: userName, userToken: userToken, dismissAction: {
                    showingRecommendToUsersPersonallyView = false
                })
                .environmentObject(viewModel)
            } else if let pinnedRecording = selectedPinnedRecording {
                RecommendToUsersPersonallyView(item: pinnedRecording, userName: userName, userToken: userToken, dismissAction: {
                    showingRecommendToUsersPersonallyView = false
                })
                .environmentObject(viewModel)
            }
        }
        .centeredModal(isPresented: $showWriteReview) {
            if let taste = selectedTaste {
                WriteAReviewView(isPresented: $showWriteReview, item: taste, userToken: userToken, userName: userName) {
                    showWriteReview = false
                }
                .environmentObject(viewModel)
            } else if let pinnedRecording = selectedPinnedRecording {
                WriteAReviewView(isPresented: $showWriteReview, item: pinnedRecording, userToken: userToken, userName: userName) {
                    showWriteReview = false
                }
                .environmentObject(viewModel)
            }
        }
    }
}





