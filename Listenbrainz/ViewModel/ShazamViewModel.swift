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
    @Published var selectedAudioURL: URL?
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
    @Published private(set) var isMatching = false
    
    
    //MARK:- Init
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    //MARK:- Methods
    
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
    
    func startMatching() {
        guard let signature = signature(from: selectedAudioURL!), isMatching == false else { return }
        isMatching = true
        session.match(signature)
    }
    //MARK:- Private Methods
    
    private func buffer(audioFile: AVAudioFile, outputFormat: AVAudioFormat) -> AVAudioPCMBuffer? {
        let frameCount = AVAudioFrameCount((1024 * 64) / (audioFile.processingFormat.streamDescription.pointee.mBytesPerFrame))
        let outputFrameCapacity = AVAudioFrameCount(12 * audioFile.fileFormat.sampleRate)
        guard let inputBuffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: frameCount),
              let outputBuffer = AVAudioPCMBuffer(pcmFormat: outputFormat, frameCapacity: outputFrameCapacity),
              let converter = AVAudioConverter(from: audioFile.processingFormat, to: outputFormat) else { return nil }
        while true {
            let status = converter.convert(to: outputBuffer, error: nil) { inNumPackets, outStatus in
                do {
                    try audioFile.read(into: inputBuffer)
                    outStatus.pointee = .haveData
                    return inputBuffer
                } catch {
                    if audioFile.framePosition >= audioFile.length {
                        outStatus.pointee = .endOfStream
                        return nil
                    } else {
                        outStatus.pointee = .noDataNow
                        return nil
                    }
                }
            }
            switch status {
            case .endOfStream, .error: return nil
            default: return outputBuffer
            }
        }
    }
    
    
    private func signature(from audioFileURL: URL) -> SHSignature? {
        guard let audioFile = try? AVAudioFile(forReading: audioFileURL),
              let audioFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1),
              let buffer = buffer(audioFile: audioFile, outputFormat: audioFormat) else { return nil }
        let signatureGenerator = SHSignatureGenerator()
        try? signatureGenerator.append(buffer, at: nil)
        return signatureGenerator.signature()
    }
}

//MARK:- Extensions

extension ShazamViewModel: SHSessionDelegate {
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        guard let matchedMediaItem = match.mediaItems.first else { return }
        DispatchQueue.main.async { [weak self] in
            
            self?.mediaItem = matchedMediaItem
            self?.stop()
            self?.isMatching = false
            
        }
        
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        print(String(describing: error))
        DispatchQueue.main.async { [weak self] in
            
            self?.isMatching = false
            self?.error = error
            self?.stop()
        }
    }
}

