//
// Copyright 2023 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Combine
@testable import ElementX
import Foundation
import XCTest

@MainActor
class AudioPlayerStateTests: XCTestCase {
    private var audioPlayerState: AudioPlayerState!
    private var audioPlayerMock: AudioPlayerMock!
    
    private var audioPlayerActionsSubject: PassthroughSubject<AudioPlayerAction, Never>!
    private var audioPlayerActions: AnyPublisher<AudioPlayerAction, Never> {
        audioPlayerActionsSubject.eraseToAnyPublisher()
    }
    
    private var audioPlayerSeekCallsSubject: PassthroughSubject<Double, Never>!
    private var audioPlayerSeekCalls: AnyPublisher<Double, Never> {
        audioPlayerSeekCallsSubject.eraseToAnyPublisher()
    }
    
    private func buildAudioPlayerMock() -> AudioPlayerMock {
        let audioPlayerMock = AudioPlayerMock()
        audioPlayerMock.underlyingActions = audioPlayerActions
        audioPlayerMock.currentTime = 0.0
        audioPlayerMock.seekToClosure = { [audioPlayerSeekCallsSubject] progress in
            audioPlayerSeekCallsSubject?.send(progress)
        }
        return audioPlayerMock
    }
    
    override func setUp() async throws {
        audioPlayerActionsSubject = .init()
        audioPlayerSeekCallsSubject = .init()
        audioPlayerState = AudioPlayerState(duration: 10.0)
        audioPlayerMock = buildAudioPlayerMock()
    }
    
    func testAttach() async throws {
        audioPlayerState.attachAudioPlayer(audioPlayerMock)
        
        XCTAssert(audioPlayerState.isAttached)
        XCTAssertEqual(audioPlayerState.playbackState, .loading)
    }
    
    func testDetach() async throws {
        audioPlayerState.attachAudioPlayer(audioPlayerMock)
        
        audioPlayerState.detachAudioPlayer()
        XCTAssert(audioPlayerMock.stopCalled)
        XCTAssertFalse(audioPlayerState.isAttached)
        XCTAssertEqual(audioPlayerState.playbackState, .stopped)
    }
    
    func testReportError() async throws {
        XCTAssertEqual(audioPlayerState.playbackState, .stopped)
        audioPlayerState.reportError(AudioPlayerError.genericError)
        XCTAssertEqual(audioPlayerState.playbackState, .error)
    }
    
    func testUpdateProgress() async throws {
        audioPlayerState.attachAudioPlayer(audioPlayerMock)

        // If we try to set a negative progress, the new progress must be 0.0
        do {
            await audioPlayerState.updateState(progress: -5.0)
            XCTAssertEqual(audioPlayerState.progress, 0.0)
            XCTAssertEqual(audioPlayerMock.seekToReceivedProgress, 0.0)
        }

        // If we try to set a progress > 1.0, the new progress must be 1.0
        do {
            await audioPlayerState.updateState(progress: 1.5)
            XCTAssertEqual(audioPlayerState.progress, 1.0)
            XCTAssertEqual(audioPlayerMock.seekToReceivedProgress, 1.0)
        }
        
        do {
            await audioPlayerState.updateState(progress: 0.4)
            XCTAssertEqual(audioPlayerState.progress, 0.4)
            XCTAssertEqual(audioPlayerMock.seekToReceivedProgress, 0.4)
        }
    }

    func testHandlingAudioPlayerActionDidStartLoading() async throws {
        audioPlayerState.attachAudioPlayer(audioPlayerMock)

        let deferred = deferFulfillment(audioPlayerState.$playbackState) { action in
            switch action {
            case .loading:
                return true
            default:
                return false
            }
        }
        
        audioPlayerActionsSubject.send(.didStartLoading)
        try await deferred.fulfill()
        XCTAssertEqual(audioPlayerState.playbackState, .loading)
    }

    func testHandlingAudioPlayerActionDidFinishLoading() async throws {
        let originalStateProgress = 0.4
        await audioPlayerState.updateState(progress: originalStateProgress)
        audioPlayerState.attachAudioPlayer(audioPlayerMock)

        let deferred = deferFulfillment(audioPlayerState.$playbackState) { action in
            switch action {
            case .readyToPlay:
                return true
            default:
                return false
            }
        }
        
        audioPlayerActionsSubject.send(.didFinishLoading)
        try await deferred.fulfill()
        
        // The state is expected to be .readyToPlay
        XCTAssertEqual(audioPlayerState.playbackState, .readyToPlay)
    }
    
    func testHandlingAudioPlayerActionDidStartPlaying() async throws {
        await audioPlayerState.updateState(progress: 0.4)
        audioPlayerState.attachAudioPlayer(audioPlayerMock)

        let deferred = deferFulfillment(audioPlayerState.$playbackState) { action in
            switch action {
            case .playing:
                return true
            default:
                return false
            }
        }
        
        audioPlayerActionsSubject.send(.didStartPlaying)
        try await deferred.fulfill()
        XCTAssertEqual(audioPlayerMock.seekToReceivedProgress, 0.4)
        XCTAssertEqual(audioPlayerState.playbackState, .playing)
        XCTAssert(audioPlayerState.isPublishingProgress)
    }
    
    func testHandlingAudioPlayerActionDidPausePlaying() async throws {
        await audioPlayerState.updateState(progress: 0.4)
        audioPlayerState.attachAudioPlayer(audioPlayerMock)

        let deferred = deferFulfillment(audioPlayerState.$playbackState) { action in
            switch action {
            case .stopped:
                return true
            default:
                return false
            }
        }
        
        audioPlayerActionsSubject.send(.didPausePlaying)
        try await deferred.fulfill()
        XCTAssertEqual(audioPlayerState.playbackState, .stopped)
        XCTAssertEqual(audioPlayerState.progress, 0.4)
        XCTAssertFalse(audioPlayerState.isPublishingProgress)
    }
    
    func testHandlingAudioPlayerActionsidStopPlaying() async throws {
        await audioPlayerState.updateState(progress: 0.4)
        audioPlayerState.attachAudioPlayer(audioPlayerMock)

        let deferred = deferFulfillment(audioPlayerState.$playbackState) { action in
            switch action {
            case .stopped:
                return true
            default:
                return false
            }
        }
        
        audioPlayerActionsSubject.send(.didStopPlaying)
        try await deferred.fulfill()
        XCTAssertEqual(audioPlayerState.playbackState, .stopped)
        XCTAssertEqual(audioPlayerState.progress, 0.4)
        XCTAssertFalse(audioPlayerState.isPublishingProgress)
    }
    
    func testAudioPlayerActionsDidFinishPlaying() async throws {
        await audioPlayerState.updateState(progress: 0.4)
        audioPlayerState.attachAudioPlayer(audioPlayerMock)

        let deferred = deferFulfillment(audioPlayerState.$playbackState) { action in
            switch action {
            case .stopped:
                return true
            default:
                return false
            }
        }
        
        audioPlayerActionsSubject.send(.didFinishPlaying)
        try await deferred.fulfill()
        XCTAssertEqual(audioPlayerState.playbackState, .stopped)
        // Progress should be reset to 0
        XCTAssertEqual(audioPlayerState.progress, 0.0)
        XCTAssertFalse(audioPlayerState.isPublishingProgress)
    }
}
