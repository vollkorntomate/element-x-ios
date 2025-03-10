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

// sourcery: AutoMockable
protocol UserIndicatorControllerProtocol: CoordinatorProtocol {
    func submitIndicator(_ indicator: UserIndicator, delay: Duration?)
    func retractIndicatorWithId(_ id: String)
    func retractAllIndicators()
    var alertInfo: AlertInfo<UUID>? { get set }
}

extension UserIndicatorControllerProtocol {
    func submitIndicator(_ indicator: UserIndicator) {
        submitIndicator(indicator, delay: nil)
    }
}
