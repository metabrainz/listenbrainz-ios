//
//  ShazamViewModel.swift
//  Listenbrainz
//
//  Created by Gaurav Bhardwaj on 19/07/23.
//

import SwiftUI
import ShazamKit

final class ShazamViewModel: NSObject, ObservableObject {

    enum ShazamError: Error, LocalizedError {
        case recordDenied
        case unknown

        var errorDescription: String? {
            switch self {
            case .recordDenied:
                return "Record permission is denied. Please enable it in Settings."
            case .unknown:
                return "Unknown error."
            }
        }
    }

    @Published var matching: Bool = false
    @Published var mediaItem: SHMatchedMediaItem?
    @Published var error: Error? {
        didSet {
            hasError = error != nil
        }
    }
    @Published var hasError: Bool = false

    private lazy var audioSession: AVAudioSession = .sharedInstance()
    private lazy var session: SHSession = .init()
    private lazy var audioEngine: AVAudioEngine = .init()
    private lazy var inputNode = self.audioEngine.inputNode
    private lazy var bus: AVAudioNodeBus = 0

    override init() {
        super.init()
        session.delegate = self
    }

    func start() {
        switch audioSession.recordPermission {
        case .granted:
            self.record()
        case .denied:
            DispatchQueue.main.async {
                self.error = ShazamError.recordDenied
            }
        case .undetermined:
            audioSession.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.record()
                    }
                    else {
                        self.error = ShazamError.recordDenied
                    }
                }
            }
        @unknown default:
            DispatchQueue.main.async {
                self.error = ShazamError.unknown
            }
        }
    }

    func stop() {
        self.audioEngine.stop()
        self.inputNode.removeTap(onBus: bus)
        self.matching = false
    }

    private func record() {
        do {
            self.matching = true
            let format = self.inputNode.outputFormat(forBus: bus)
            self.inputNode.installTap(onBus: bus, bufferSize: 1024, format: format) { buffer, time in
                self.session.matchStreamingBuffer(buffer, at: time)
            }
            self.audioEngine.prepare()
            try self.audioEngine.start()
        }
        catch {
            self.error = error
        }
    }
}

extension ShazamViewModel: SHSessionDelegate {

    func session(_ session: SHSession, didFind match: SHMatch) {
        DispatchQueue.main.async {
            if let mediaItem = match.mediaItems.first {
                self.mediaItem = mediaItem
                self.stop()
            }
        }
    }

    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        DispatchQueue.main.async {
            self.error = error
            self.stop()
        }
    }
}

