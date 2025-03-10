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

import SwiftUI

struct SeparatorRoomTimelineView: View {
    let timelineItem: SeparatorRoomTimelineItem
    
    var body: some View {
        Text(timelineItem.text)
            .font(.compound.bodySMSemibold)
            .foregroundColor(.compound.textPrimary)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 36.0)
            .padding(.vertical, 8.0)
    }
}

struct SeparatorRoomTimelineView_Previews: PreviewProvider, TestablePreview {
    static var previews: some View {
        let item = SeparatorRoomTimelineItem(id: .init(timelineID: "Separator"), text: "This is a separator")
        SeparatorRoomTimelineView(timelineItem: item)
    }
}
