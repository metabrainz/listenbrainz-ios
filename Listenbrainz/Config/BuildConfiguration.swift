//
//  BuildConfiguration.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 15/01/24.
//

import Foundation

class BuildConfiguration {
    static let shared = BuildConfiguration()

    var environment: AppEnvironment

    var WEBSITE_LISTENBRAINZ_BASE_URL: String {
        switch environment {
        case .dev:
            return "https://listenbrainz.org"
        case .beta:
            return "https://beta.listenbrainz.org"
        case .release:
            return "https://listenbrainz.org"
        }
    }

    var API_LISTENBRAINZ_BASE_URL: String {
        switch environment {
        case .dev:
            return "https://api.listenbrainz.org/1"
        case .beta:
            return "https://beta-api.listenbrainz.org/1"
        case .release:
            return "https://api.listenbrainz.org/1"
        }
    }
    
    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String

        environment = AppEnvironment(rawValue: currentConfiguration)!
    }
}
