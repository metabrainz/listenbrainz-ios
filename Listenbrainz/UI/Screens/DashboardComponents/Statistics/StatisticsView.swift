//
//  StatisticsView.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import SwiftUI
import Charts

struct StatisticsView: View {
  @EnvironmentObject var viewModel: DashboardViewModel
  @EnvironmentObject var userSelection: UserSelection
    @AppStorage(Strings.AppStorageKeys.userName) private var storedUserName: String = ""
    @State private var isSettingsPressed = false
    @State private var isSearchActive = false

    var body: some View {
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {

                    Text("Listening Activity")
                        .font(.title)
                        .padding([.top, .leading])

                    if viewModel.listeningActivity.isEmpty {
                        Text("No listening activity available")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding([.leading, .trailing])
                    } else {
                        ListeningActivityBarChart(listeningActivity: viewModel.listeningActivity)
                            .frame(height: 300)
                            .padding()
                    }
                }
            }

            VStack(alignment: .leading) {
                Text("Top Artists")
                    .font(.title)
                    .padding([.top, .leading])

                if viewModel.topArtists.isEmpty {
                    Text("No top artists available")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing])
                } else {
                    ForEach(viewModel.topArtists.prefix(10), id: \.artistName) { artist in
                        TopArtistRowView(artist: artist)
                            .padding([.leading, .trailing])
                    }
                }
            }

            VStack(alignment: .leading) {
                Text("Top Albums")
                    .font(.title)
                    .padding([.top, .leading])

                if viewModel.topAlbums.isEmpty {
                    Text("No top albums available")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing])
                } else {
                  ForEach(viewModel.topAlbums.prefix(10), id: \.caaReleaseMbid) { album in
                        TopAlbumRowView(album: album)
                            .padding([.leading, .trailing])
                    }
                }
            }


            VStack(alignment: .leading) {
                Text("Top Tracks")
                    .font(.title)
                    .padding([.top, .leading])

                if viewModel.topTracks.isEmpty {
                    Text("No top tracks available")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing])
                } else {
                    ForEach(viewModel.topTracks.prefix(10), id: \.caaReleaseMbid) { track in
                        TopTrackRowView(track: track)
                            .padding([.leading, .trailing])
                    }
                }
            }

          VStack(alignment:.leading){
              Text("Daily Activity")
                .font(.title)
                .padding([.top, .leading])
            ScrollView(.horizontal){
              if !viewModel.hours.isEmpty && !viewModel.counts.isEmpty {
                HeatMapActivityView(hours: viewModel.hours, counts: viewModel.counts)
                  .frame(height: 200)
              } else {
                Text("Loading...")
              }
            }

          }
        }
        .onAppear {
          viewModel.getListeningActivity(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
          viewModel.getTopArtists(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
          viewModel.getTopAlbums(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
          viewModel.getTopTracks(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
          viewModel.getDailyActivity(username: userSelection.selectedUserName.isEmpty ? storedUserName : userSelection.selectedUserName)
        }
    }
}

struct TopArtistRowView: View {
    let artist: ArtistElement

    var body: some View {
        HStack {
            Text(artist.artistName)
                .font(.headline)
                .foregroundColor(Color.LbPurple)
            Spacer()
            Text("\(artist.listenCount)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.1))
        .cornerRadius(8)
    }
}



struct TopAlbumRowView: View {
    let album: Release

    var body: some View {
        HStack {
            if let url = album.coverArtURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                } placeholder: {
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
            } else {
                Image(systemName: "music.note")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading) {
              Text(album.releaseName)
                    .font(.headline)
              Text(album.artistName)
                    .font(.subheadline)
            }
            .foregroundColor(Color.LbPurple)
            Spacer()
            Text("\(album.listenCount)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.1))
        .cornerRadius(8)
    }
}

struct TopTrackRowView: View {
    let track: Recording

    var body: some View {
        HStack {
            if let url = track.coverArtURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                } placeholder: {
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                }
            } else {
                Image(systemName: "music.note")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading) {
                Text(track.trackName)
                    .font(.headline)
                Text(track.artistName)
                    .font(.subheadline)
            }
            .foregroundColor(Color.LbPurple)
            Spacer()
            Text("\(track.listenCount)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.1))
        .cornerRadius(8)
    }
}




struct HeatMapActivityView: View {
    let hours: [Int]
    let counts: [Int]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: Array(repeating: GridItem(.flexible()), count: 7), spacing: 1) {
                ForEach(0..<hours.count, id: \.self) { index in
                    Rectangle()
                        .fill(heatMapColor(for: counts[index]))
                        .frame(width: 18, height: 18)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10))
    }

    private func heatMapColor(for listenCount: Int) -> Color {
        switch listenCount {
        case 0..<35:
            return Color(red: 0.93, green: 0.92, blue: 0.94)
        case 35..<50:
            return Color(red: 0.84, green: 0.61, blue: 0.49)
        case 50..<75:
            return Color(red: 0.74, green: 0.71, blue: 0.89)
        case 75..<100:
            return Color(red: 0.20, green: 0.18, blue: 0.49)
        default:
            return Color(red: 0.89, green: 0.45, blue: 0.24)
        }
    }
}

struct ListeningActivityBarChart: View {
    var listeningActivity: [ListeningActivity]

    var body: some View {
        Chart(filteredListeningActivity) { activity in
            BarMark(
                x: .value("Time Range", activity.timeRange),
                y: .value("Listen Count", activity.listenCount)
            )
            .foregroundStyle(Color.primary)
            .cornerRadius(4)
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisValueLabel {
                    if let intValue = value.as(Int.self) {
                        Text("\(intValue / 1000)k")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel {
                    if let stringValue = value.as(String.self) {
                        Text(stringValue.prefix(4))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .chartLegend(.hidden)
        .padding()
        .frame(width: calculateChartWidth(for: filteredListeningActivity.count))
    }

    private var filteredListeningActivity: [ListeningActivity] {
        listeningActivity.filter { $0.listenCount > 0 }
    }

    private func calculateChartWidth(for count: Int) -> CGFloat {
        let baseWidth: CGFloat = 50
        let spacing: CGFloat = 10
        return CGFloat(count) * (baseWidth + spacing)
    }
}
