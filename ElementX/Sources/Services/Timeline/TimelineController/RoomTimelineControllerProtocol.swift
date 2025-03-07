//
// Copyright 2022 New Vector Ltd
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
import Foundation
import UIKit

enum RoomTimelineControllerCallback {
    case updatedTimelineItems
    case canBackPaginate(Bool)
    case isBackPaginating(Bool)
}

enum RoomTimelineControllerAction {
    case displayMediaFile(file: MediaFileHandleProxy, title: String?)
    case displayLocation(body: String, geoURI: GeoURI, description: String?)
    case none
}

enum RoomTimelineControllerError: Error {
    case generic
}

@MainActor
protocol RoomTimelineControllerProtocol {
    var roomID: String { get }
    
    var timelineItems: [RoomTimelineItemProtocol] { get }
    var callbacks: PassthroughSubject<RoomTimelineControllerCallback, Never> { get }
    
    func processItemAppearance(_ itemID: TimelineItemIdentifier) async
    
    func processItemDisappearance(_ itemID: TimelineItemIdentifier) async

    func processItemTap(_ itemID: TimelineItemIdentifier) async -> RoomTimelineControllerAction
    
    func paginateBackwards(requestSize: UInt, untilNumberOfItems: UInt) async -> Result<Void, RoomTimelineControllerError>
    
    func sendReadReceipt(for itemID: TimelineItemIdentifier) async -> Result<Void, RoomTimelineControllerError>
    
    func sendMessage(_ message: String, html: String?, inReplyTo itemID: TimelineItemIdentifier?) async
    
    func editMessage(_ newMessage: String, html: String?, original itemID: TimelineItemIdentifier) async
    
    func toggleReaction(_ reaction: String, to itemID: TimelineItemIdentifier) async

    func redact(_ itemID: TimelineItemIdentifier) async

    func cancelSend(_ itemID: TimelineItemIdentifier) async
    
    func debugInfo(for itemID: TimelineItemIdentifier) -> TimelineItemDebugInfo
    
    func retryDecryption(for sessionID: String) async
    
    func audioPlayerState(for itemID: TimelineItemIdentifier) -> AudioPlayerState
    
    func playPauseAudio(for itemID: TimelineItemIdentifier) async
    
    func pauseAudio()
    
    func seekAudio(for itemID: TimelineItemIdentifier, progress: Double) async
}

extension RoomTimelineControllerProtocol {
    func sendMessage(_ message: String, html: String?) async {
        await sendMessage(message, html: html, inReplyTo: nil)
    }
}
