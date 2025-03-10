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

struct HomeScreenInvitesButton: View {
    @ScaledMetric private var badgeSize = 12.0
    
    let title: String
    let hasBadge: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8.0) {
                Text(title)
                    .foregroundColor(.compound.textPrimary)
                    .font(.compound.bodyMDSemibold)
                
                if hasBadge {
                    badge
                }
            }
            .padding(.trailing, 16.0)
            .padding(.leading, 64.0)
            .padding(.vertical, 8.0)
        }
    }
    
    // MARK: - Private
    
    private var badge: some View {
        Circle()
            .frame(width: badgeSize, height: badgeSize)
            .foregroundColor(.compound.iconAccentTertiary)
    }
}

struct HomeScreenInvitesButton_Previews: PreviewProvider, TestablePreview {
    static var previews: some View {
        HomeScreenInvitesButton(title: "Invites", hasBadge: true, action: { })
            .previewDisplayName("Badge on")
        
        HomeScreenInvitesButton(title: "Invites", hasBadge: false, action: { })
            .previewDisplayName("Badge off")
        
        HomeScreenInvitesButton(title: "Invites", hasBadge: true, action: { })
            .previewDisplayName("Badge on (AX1)")
            .dynamicTypeSize(.accessibility1)
    }
}
