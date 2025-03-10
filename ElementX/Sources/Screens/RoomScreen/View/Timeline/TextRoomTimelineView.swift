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

import Foundation
import SwiftUI

struct TextRoomTimelineView: View, TextBasedRoomTimelineViewProtocol {
    let timelineItem: TextRoomTimelineItem
    @Environment(\.timelineStyle) var timelineStyle
    
    var body: some View {
        TimelineStyler(timelineItem: timelineItem) {
            if let attributedString = timelineItem.content.formattedBody {
                FormattedBodyText(attributedString: attributedString,
                                  additionalWhitespacesCount: timelineItem.additionalWhitespaces(timelineStyle: timelineStyle),
                                  boostEmojiSize: true)
            } else {
                FormattedBodyText(text: timelineItem.body,
                                  additionalWhitespacesCount: timelineItem.additionalWhitespaces(timelineStyle: timelineStyle),
                                  boostEmojiSize: true)
            }
        }
    }
}

struct TextRoomTimelineView_Previews: PreviewProvider, TestablePreview {
    static let viewModel = RoomScreenViewModel.mock
    
    static var previews: some View {
        body.environmentObject(viewModel.context)
        body
            .environment(\.timelineStyle, .plain)
            .environmentObject(viewModel.context)
    }
    
    static var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            TextRoomTimelineView(timelineItem: itemWith(text: "Short loin ground round tongue hamburger, fatback salami shoulder. Beef turkey sausage kielbasa strip steak. Alcatra capicola pig tail pancetta chislic.",
                                                        timestamp: "Now",
                                                        isOutgoing: false,
                                                        senderId: "Bob"))

            TextRoomTimelineView(timelineItem: itemWith(text: "Some other text",
                                                        timestamp: "Later",
                                                        isOutgoing: true,
                                                        senderId: "Anne"))

            TextRoomTimelineView(timelineItem: itemWith(text: "Short loin ground round tongue hamburger, fatback salami shoulder. Beef turkey sausage kielbasa strip steak. Alcatra capicola pig tail pancetta chislic.",
                                                        timestamp: "Now",
                                                        isOutgoing: false,
                                                        senderId: "Bob"))

            TextRoomTimelineView(timelineItem: itemWith(text: "Some other text",
                                                        timestamp: "Later",
                                                        isOutgoing: true,
                                                        senderId: "Anne"))
        }
    }
    
    private static func itemWith(text: String, timestamp: String, isOutgoing: Bool, senderId: String) -> TextRoomTimelineItem {
        TextRoomTimelineItem(id: .random,
                             timestamp: timestamp,
                             isOutgoing: isOutgoing,
                             isEditable: isOutgoing,
                             canBeRepliedTo: true,
                             isThreaded: false,
                             sender: .init(id: senderId),
                             content: .init(body: text))
    }
}
