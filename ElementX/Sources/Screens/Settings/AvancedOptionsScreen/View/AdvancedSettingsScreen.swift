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

import Compound
import SwiftUI

struct AdvancedSettingsScreen: View {
    @ObservedObject var context: AdvancedSettingsScreenViewModel.Context
    
    var body: some View {
        Form {
            Section {
                ListRow(label: .default(title: L10n.commonMessageLayout,
                                        systemIcon: .rectangleGrid1x2),
                        kind: .picker(selection: $context.timelineStyle,
                                      items: TimelineStyle.allCases.map { (title: $0.name, tag: $0) }))
                
                ListRow(label: .default(title: L10n.commonRichTextEditor, icon: Image(asset: Asset.Images.textFormat)),
                        kind: .toggle($context.richTextEditorEnabled))
                
                ListRow(label: .default(title: L10n.actionViewSource, systemIcon: .mailAndTextMagnifyingglass),
                        kind: .toggle($context.viewSourceEnabled))
            }
        }
        .compoundList()
        .navigationTitle(L10n.commonAdvancedSettings)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension TimelineStyle {
    var name: String {
        switch self {
        case .plain:
            return L10n.commonModern
        case .bubbles:
            return L10n.commonBubbles
        }
    }
}

// MARK: - Previews

struct AdvancedSettingsScreen_Previews: PreviewProvider, TestablePreview {
    static let viewModel = AdvancedSettingsScreenViewModel(advancedSettings: ServiceLocator.shared.settings)
    static var previews: some View {
        NavigationStack {
            AdvancedSettingsScreen(context: viewModel.context)
        }
    }
}
