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

import Foundation
import SwiftUI

struct VoiceMessageRoomTimelineView: View {
    @EnvironmentObject private var context: RoomScreenViewModel.Context
    private let timelineItem: VoiceMessageRoomTimelineItem
    private let playerState: AudioPlayerState
    @State private var resumePlaybackAfterScrubbing = false
    
    init(timelineItem: VoiceMessageRoomTimelineItem, playerState: AudioPlayerState) {
        self.timelineItem = timelineItem
        self.playerState = playerState
    }
    
    var body: some View {
        TimelineStyler(timelineItem: timelineItem) {
            VoiceMessageRoomPlaybackView(playerState: playerState,
                                         onPlayPause: onPlaybackPlayPause,
                                         onSeek: { onPlaybackSeek($0) },
                                         onScrubbing: { onPlaybackScrubbing($0) })
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private func onPlaybackPlayPause() {
        context.send(viewAction: .playPauseAudio(itemID: timelineItem.id))
    }
    
    private func onPlaybackSeek(_ progress: Double) {
        context.send(viewAction: .seekAudio(itemID: timelineItem.id, progress: progress))
    }
    
    private func onPlaybackScrubbing(_ dragging: Bool) {
        if dragging {
            if playerState.playbackState == .playing {
                resumePlaybackAfterScrubbing = true
                context.send(viewAction: .playPauseAudio(itemID: timelineItem.id))
            }
            context.send(viewAction: .disableLongPress(itemID: timelineItem.id))
        } else {
            context.send(viewAction: .enableLongPress(itemID: timelineItem.id))
            if resumePlaybackAfterScrubbing {
                context.send(viewAction: .playPauseAudio(itemID: timelineItem.id))
                resumePlaybackAfterScrubbing = false
            }
        }
    }
}

struct VoiceMessageRoomTimelineView_Previews: PreviewProvider, TestablePreview {
    static let viewModel = RoomScreenViewModel.mock

    static let voiceRoomTimelineItem = VoiceMessageRoomTimelineItem(id: .random,
                                                                    timestamp: "Now",
                                                                    isOutgoing: false,
                                                                    isEditable: false,
                                                                    canBeRepliedTo: true,
                                                                    isThreaded: false,
                                                                    sender: .init(id: "Bob"),
                                                                    content: .init(body: "audio.ogg",
                                                                                   duration: 300,
                                                                                   waveform: Waveform.mockWaveform,
                                                                                   source: nil,
                                                                                   contentType: nil))
    
    static let playerState = AudioPlayerState(duration: 10.0,
                                              waveform: Waveform.mockWaveform,
                                              progress: 0.4)
    
    static var previews: some View {
        body.environmentObject(viewModel.context)
            .previewDisplayName("Bubble")
        body
            .environment(\.timelineStyle, .plain)
            .environmentObject(viewModel.context)
            .previewDisplayName("Plain")
    }
    
    static var body: some View {
        VoiceMessageRoomTimelineView(timelineItem: voiceRoomTimelineItem, playerState: playerState)
            .fixedSize(horizontal: false, vertical: true)
    }
}
