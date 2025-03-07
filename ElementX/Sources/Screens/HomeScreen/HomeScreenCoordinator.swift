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
import SwiftUI

struct HomeScreenCoordinatorParameters {
    let userSession: UserSessionProtocol
    let attributedStringBuilder: AttributedStringBuilderProtocol
    let bugReportService: BugReportServiceProtocol
    let navigationStackCoordinator: NavigationStackCoordinator
    let selectedRoomPublisher: CurrentValuePublisher<String?, Never>
}

enum HomeScreenCoordinatorAction {
    case presentRoom(roomIdentifier: String)
    case presentRoomDetails(roomIdentifier: String)
    case roomLeft(roomIdentifier: String)
    case presentSettingsScreen
    case presentFeedbackScreen
    case presentSessionVerificationScreen
    case presentStartChatScreen
    case presentInvitesScreen
    case signOut
}

final class HomeScreenCoordinator: CoordinatorProtocol {
    private let parameters: HomeScreenCoordinatorParameters
    private var viewModel: HomeScreenViewModelProtocol
    
    private let actionsSubject: PassthroughSubject<HomeScreenCoordinatorAction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    var actions: AnyPublisher<HomeScreenCoordinatorAction, Never> {
        actionsSubject.eraseToAnyPublisher()
    }
    
    init(parameters: HomeScreenCoordinatorParameters) {
        self.parameters = parameters
        
        viewModel = HomeScreenViewModel(userSession: parameters.userSession,
                                        attributedStringBuilder: parameters.attributedStringBuilder,
                                        selectedRoomPublisher: parameters.selectedRoomPublisher,
                                        appSettings: ServiceLocator.shared.settings,
                                        analytics: ServiceLocator.shared.analytics,
                                        userIndicatorController: ServiceLocator.shared.userIndicatorController)
        
        viewModel.actions
            .sink { [weak self] action in
                guard let self else { return }
                
                switch action {
                case .presentRoom(let roomIdentifier):
                    actionsSubject.send(.presentRoom(roomIdentifier: roomIdentifier))
                case .presentRoomDetails(roomIdentifier: let roomIdentifier):
                    actionsSubject.send(.presentRoomDetails(roomIdentifier: roomIdentifier))
                case .roomLeft(roomIdentifier: let roomIdentifier):
                    actionsSubject.send(.roomLeft(roomIdentifier: roomIdentifier))
                case .presentFeedbackScreen:
                    actionsSubject.send(.presentFeedbackScreen)
                case .presentSettingsScreen:
                    actionsSubject.send(.presentSettingsScreen)
                case .presentSessionVerificationScreen:
                    actionsSubject.send(.presentSessionVerificationScreen)
                case .signOut:
                    actionsSubject.send(.signOut)
                case .presentStartChatScreen:
                    actionsSubject.send(.presentStartChatScreen)
                case .presentInvitesScreen:
                    actionsSubject.send(.presentInvitesScreen)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public
    
    func start() {
        #if !DEBUG
        if parameters.bugReportService.crashedLastRun {
            viewModel.presentCrashedLastRunAlert()
        }
        #endif
    }
    
    func toPresentable() -> AnyView {
        AnyView(HomeScreen(context: viewModel.context))
    }
}
