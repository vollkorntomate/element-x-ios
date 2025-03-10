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

import MatrixRustSDK
import SwiftUI

struct UserProfileCell: View {
    let user: UserProfileProxy
    let membership: MembershipState?
    let imageProvider: ImageProviderProtocol?
    
    private var subtitle: String? {
        if let membershipText = membership?.localizedDescription {
            return membershipText
        } else if user.displayName != nil {
            return user.userID
        } else {
            return nil
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            LoadableAvatarImage(url: user.avatarURL,
                                name: user.displayName,
                                contentID: user.userID,
                                avatarSize: .user(on: .startChat),
                                imageProvider: imageProvider)
                .accessibilityHidden(true)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(user.displayName ?? user.userID)
                    .font(.compound.headingSM)
                    .foregroundColor(.compound.textPrimary)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.compound.bodyMD)
                        .foregroundColor(.compound.textSecondary)
                }
                
                warningContent
                    .padding(.top, 2)
            }
            .accessibilityElement(children: .combine)
        }
    }
    
    // MARK: - Private
    
    @ViewBuilder
    private var warningContent: some View {
        if !user.isVerified, membership == nil {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text(Image(systemName: "exclamationmark.circle.fill"))
                    .foregroundColor(.compound.textCriticalPrimary)
                
                Text(L10n.commonInviteUnknownProfile)
                    .foregroundColor(.compound.textSecondary)
            }
            .font(.compound.bodyXS)
        }
    }
}

private extension MembershipState {
    var localizedDescription: String? {
        switch self {
        case .join:
            return L10n.screenRoomDetailsAlreadyAMember
        case .invite:
            return L10n.screenRoomDetailsAlreadyInvited
        default:
            return nil
        }
    }
}

struct UserProfileCell_Previews: PreviewProvider, TestablePreview {
    static let action: () -> Void = { }
    
    static var previews: some View {
        Form {
            Button(action: action) {
                UserProfileCell(user: .mockAlice, membership: nil, imageProvider: MockMediaProvider())
            }
            .buttonStyle(FormButtonStyle(accessory: .multipleSelection(isSelected: true)))
            .previewDisplayName("Selected user")

            Button(action: action) {
                UserProfileCell(user: .mockBob, membership: nil, imageProvider: MockMediaProvider())
            }
            .buttonStyle(FormButtonStyle(accessory: .multipleSelection(isSelected: false)))
            .previewDisplayName("Unselected user")
            
            Button(action: action) {
                UserProfileCell(user: .mockCharlie, membership: .join, imageProvider: MockMediaProvider())
            }
            .disabled(true)
            .buttonStyle(FormButtonStyle(accessory: .multipleSelection(isSelected: true)))
            .previewDisplayName("Selected disabled user")
            
            Button(action: action) {
                UserProfileCell(user: .init(userID: "@someone:matrix.org"), membership: .join, imageProvider: MockMediaProvider())
            }
            .disabled(true)
            .buttonStyle(FormButtonStyle(accessory: .multipleSelection(isSelected: true)))
            .previewDisplayName("Unverified joined user")
            
            Button(action: action) {
                UserProfileCell(user: .init(userID: "@someone:matrix.org"), membership: nil, imageProvider: MockMediaProvider())
            }
            .buttonStyle(FormButtonStyle(accessory: .multipleSelection(isSelected: false)))
            .previewDisplayName("Unverified user")
        }
    }
}
