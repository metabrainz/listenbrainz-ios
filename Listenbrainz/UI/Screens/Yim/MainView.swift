//
//  MainView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//



import SwiftUI

struct MainView: View {
    @StateObject var viewModel: YIMViewModel
    @AppStorage(Strings.AppStorageKeys.userName) private var userName: String = ""
    @State private var currentPage: Int = 0
    private let pageHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack(alignment: .bottom) {
            YimLandingView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 0) * pageHeight)

            ChartTitleView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 1) * pageHeight)

            CoverArtGridView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 2) * pageHeight)

            TopAlbumsView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 3) * pageHeight)

            TopRecordingsView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 4) * pageHeight)

            TopArtistsView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 5) * pageHeight)

            StatsTitleView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 6) * pageHeight)

            StatsView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 7) * pageHeight)

            HeatMapScreenView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 8) * pageHeight)

            ListeningChartView(viewModel: viewModel)
                .frame(height: pageHeight)
                .offset(y: -CGFloat(currentPage - 9) * pageHeight)

          PlaylistsTitleView(viewModel: viewModel)
              .frame(height: pageHeight)
              .offset(y: -CGFloat(currentPage - 10) * pageHeight)

          TopDiscoveriesView(viewModel: viewModel)
              .frame(height: pageHeight)
              .offset(y: -CGFloat(currentPage - 11) * pageHeight)

          DiscoverTitleView(viewModel: viewModel)
              .frame(height: pageHeight)
              .offset(y: -CGFloat(currentPage - 12) * pageHeight)

          NewReleasesView(viewModel: viewModel)
              .frame(height: pageHeight)
              .offset(y: -CGFloat(currentPage - 13) * pageHeight)

          MusicBuddiesView(viewModel: viewModel)
              .frame(height: pageHeight)
              .offset(y: -CGFloat(currentPage - 14) * pageHeight)

          YimLastView(viewModel: viewModel)
              .frame(height: pageHeight)
              .offset(y: -CGFloat(currentPage - 15) * pageHeight)


        }

        .onAppear {
            viewModel.fetchYIMData(userName: userName)

        }
        .toolbar(.hidden, for: .tabBar) ///Used for hiding the toolbar when main view is called.
        .gesture(DragGesture()
            .onEnded { value in
                let threshold: CGFloat = 50

                if value.translation.height < -threshold && currentPage < 15 {
                    nextPage()
                } else if value.translation.height > threshold && currentPage > 0 {
                    previousPage()
                }
            }

        )
    }

    private func nextPage() {
        withAnimation(.spring()) {
            currentPage = min(currentPage + 1, 15)
        }
    }

    private func previousPage() {
        withAnimation(.spring()) {
            currentPage = max(currentPage - 1, 0)
        }
    }
}

