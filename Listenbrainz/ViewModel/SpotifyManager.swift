//
//  SpotifyManager.swift
//  Listenbrainz
//
//  Created by Akshat Tiwari on 19/03/23.
//

import SwiftUI
import Combine
import SpotifyiOS

class SpotifyManager: NSObject, ObservableObject, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate, SPTSessionManagerDelegate {
    private let clientID = Constants.SPOTIFY_CLIENT_ID
    private let redirectURI = URL(string: Constants.SPOTIFY_REDIRECT_URI)!

    @Published var playerState: SPTAppRemotePlayerState?
    @Published var session: SPTSession?

    private(set) var appRemote: SPTAppRemote
    private(set) var sessionManager: SPTSessionManager

    override init() {
        let configuration = SPTConfiguration(clientID: clientID, redirectURL: redirectURI)
        configuration.tokenSwapURL = nil
        configuration.tokenRefreshURL = nil

        appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        sessionManager = SPTSessionManager(configuration: configuration, delegate: nil)

        super.init()
        
        sessionManager.delegate = self
    }

    // MARK: - SPTSessionManagerDelegate

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Session initiated")
        self.session = session
        saveSession(session)
        connect()
    }

    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Session initiation failed: \(error.localizedDescription)")
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Session renewed")
        self.session = session
    }

    // MARK: - SPTAppRemoteDelegate

    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        print("Connected to Spotify")

        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (_, error) in
            if let error = error {
                print("Error subscribing to player state: \(error.localizedDescription)")
            }
        })
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("Failed to connect to Spotify: \(error?.localizedDescription ?? "Unknown error")")
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("Disconnected from Spotify: \(error?.localizedDescription ?? "Unknown error")")
    }

    // MARK: - SPTAppRemotePlayerStateDelegate

    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        DispatchQueue.main.async {
            self.playerState = playerState
        }
    }

    // MARK: - Custom methods

    func connect() {
         if isSessionValid(), let accessToken = getAccessToken() {
             appRemote.connectionParameters.accessToken = accessToken
             appRemote.connect()
         } else {
             initiateSession()
         }
     }

    func playSong(spotifyID: String) {
        guard appRemote.isConnected else { return }
        appRemote.playerAPI?.play(spotifyID, callback: nil)
    }
    
    func saveSession(_ session: SPTSession) {
           UserDefaults.standard.set(session.accessToken, forKey: "spotifyAccessToken")
           UserDefaults.standard.set(session.expirationDate, forKey: "spotifyExpirationDate")
       }

   func initiateSession() {
       let scope: SPTScope = [.appRemoteControl, .userLibraryRead, .playlistReadPrivate, .userLibraryModify]
       sessionManager.initiateSession(with: scope, options: .default)
   }

    func isSessionValid() -> Bool {
          guard let expirationDate = UserDefaults.standard.object(forKey: "spotifyExpirationDate") as? Date else {
              return false
          }
          return Date() < expirationDate
      }

      func getAccessToken() -> String? {
          UserDefaults.standard.string(forKey: "spotifyAccessToken")
      }
}
