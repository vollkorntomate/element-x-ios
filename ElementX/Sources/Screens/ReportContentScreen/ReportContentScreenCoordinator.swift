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

struct ReportContentScreenCoordinatorParameters {
    let eventID: String
    let senderID: String
    let roomProxy: RoomProxyProtocol
    weak var userIndicatorController: UserIndicatorControllerProtocol?
}

enum ReportContentScreenCoordinatorAction {
    case cancel
    case finish
}

final class ReportContentScreenCoordinator: CoordinatorProtocol {
    private let parameters: ReportContentScreenCoordinatorParameters
    private var viewModel: ReportContentScreenViewModelProtocol
    private let actionsSubject: PassthroughSubject<ReportContentScreenCoordinatorAction, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    var actions: AnyPublisher<ReportContentScreenCoordinatorAction, Never> {
        actionsSubject.eraseToAnyPublisher()
    }
    
    init(parameters: ReportContentScreenCoordinatorParameters) {
        self.parameters = parameters
        
        viewModel = ReportContentScreenViewModel(eventID: parameters.eventID, senderID: parameters.senderID, roomProxy: parameters.roomProxy)
    }

    // MARK: - Public
    
    func start() {
        viewModel.actions
            .sink { [weak self] action in
                guard let self else { return }
                
                switch action {
                case .submitStarted:
                    startLoading()
                case let .submitFailed(error):
                    stopLoading()
                    showError(description: error.localizedDescription)
                case .submitFinished:
                    stopLoading()
                    actionsSubject.send(.finish)
                case .cancel:
                    actionsSubject.send(.cancel)
                }
            }
            .store(in: &cancellables)
    }

    func stop() {
        stopLoading()
    }
        
    func toPresentable() -> AnyView {
        AnyView(ReportContentScreen(context: viewModel.context))
    }

    // MARK: - Private

    private static let loadingIndicatorIdentifier = "ReportContentLoading"

    private func startLoading() {
        parameters.userIndicatorController?.submitIndicator(
            UserIndicator(id: Self.loadingIndicatorIdentifier,
                          type: .modal,
                          title: L10n.commonSending,
                          persistent: true)
        )
    }

    private func stopLoading() {
        parameters.userIndicatorController?.retractIndicatorWithId(Self.loadingIndicatorIdentifier)
    }

    private func showError(description: String) {
        parameters.userIndicatorController?.submitIndicator(UserIndicator(title: description))
    }
}
