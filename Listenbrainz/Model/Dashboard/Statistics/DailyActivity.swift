//
//  DailyActivity.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 12/08/24.
//

import Foundation

struct DailyActivityResponse:Codable{
  let payload:DailyActivityPayload
}

struct DailyActivityPayload: Codable {
    let dailyActivity: DailyActivity

    enum CodingKeys: String, CodingKey {
        case dailyActivity = "daily_activity"
    }
}

struct DailyActivity: Codable {
    let friday, monday, saturday, sunday: [Day]
    let thursday, tuesday, wednesday: [Day]

    enum CodingKeys: String, CodingKey {
        case friday = "Friday"
        case monday = "Monday"
        case saturday = "Saturday"
        case sunday = "Sunday"
        case thursday = "Thursday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
    }
}


struct Day: Codable {
    let hour, listenCount: Int

    enum CodingKeys: String, CodingKey {
        case hour
        case listenCount = "listen_count"
    }
}
