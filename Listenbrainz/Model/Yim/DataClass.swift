//
//  DataClass.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 11/01/24.
//

import Foundation


// MARK: - DataClass
struct DataClass: Codable {
//  let artistMap: [ArtistMap]
  let dayOfWeek: String
  let listensPerDay: [ListensPerDay]
  let mostListenedYear: [String: Int]
  let newReleasesOfTopArtists: [NewReleasesOfTopArtist]
//  let playlistTopDiscoveriesForYear, playlistTopMissedRecordingsForYear: Playlist
  let similarUsers: [String: Double]
  let playlistTopDiscoveriesForYear, playlistTopMissedRecordingsForYear: PlaylistTopSForYear?
  let topArtists: [TopArtistElement]
  let topGenres: [TopGenre]
  let topRecordings: [TopRecording]
  let topReleaseGroups: [TopReleaseGroup]
  let totalArtistsCount, totalListenCount: Int
//  let totalListeningTime: Double
//  let totalNewArtistsDiscovered, totalRecordingsCount, totalReleaseGroupsCount: Int
let totalReleaseGroupsCount: Int

  enum CodingKeys: String, CodingKey {
//    case artistMap = "artist_map"
    case dayOfWeek = "day_of_week"
    case listensPerDay = "listens_per_day"
    case mostListenedYear = "most_listened_year"
    case newReleasesOfTopArtists = "new_releases_of_top_artists"
    case playlistTopDiscoveriesForYear = "playlist-top-discoveries-for-year"
    case playlistTopMissedRecordingsForYear = "playlist-top-missed-recordings-for-year"
    case similarUsers = "similar_users"
//    case topMissedRecordings = "top-missed-recordings"
    case topArtists = "top_artists"
    case topGenres = "top_genres"
    case topRecordings = "top_recordings"
    case topReleaseGroups = "top_release_groups"
    case totalArtistsCount = "total_artists_count"
    case totalListenCount = "total_listen_count"
//    case totalListeningTime = "total_listening_time"
//    case totalNewArtistsDiscovered = "total_new_artists_discovered"
//    case totalRecordingsCount = "total_recordings_count"
    case totalReleaseGroupsCount = "total_release_groups_count"
  }

}
