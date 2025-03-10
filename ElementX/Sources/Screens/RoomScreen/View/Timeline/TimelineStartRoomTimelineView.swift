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

import SwiftUI

struct TimelineStartRoomTimelineView: View {
    let timelineItem: TimelineStartRoomTimelineItem
    
    var body: some View {
        Text(title)
            .font(.compound.bodySM)
            .foregroundColor(.compound.textSecondary)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
    }
    
    var title: String {
        var text = L10n.roomTimelineBeginningOfRoomNoName
        if let name = timelineItem.name {
            text = L10n.roomTimelineBeginningOfRoom(name)
        }
        return text
    }
}

struct TimelineStartRoomTimelineView_Previews: PreviewProvider, TestablePreview {
    static var previews: some View {
        let item = TimelineStartRoomTimelineItem(name: "Alice and Bob")
        TimelineStartRoomTimelineView(timelineItem: item)
    }
}
