//
// Copyright 2021 New Vector Ltd
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

import AnalyticsEvents
import PostHog

/// A class responsible for managing a variety of analytics clients
/// and sending events through these clients.
///
/// Events may include user activity, or app health data such as crashes,
/// non-fatal issues and performance. `Analytics` class serves as a façade
/// to all these use cases.
///
/// ## Creating Analytics Events
///
/// Events are managed in a shared repo for all Element clients https://github.com/matrix-org/matrix-analytics-events
/// To add a new event create a PR to that repo with the new/updated schema. Once merged
/// into `main`, update the AnalyticsEvents Swift package in `project.yml`.
///
class AnalyticsService {
    /// The analytics client to send events with.
    private let client: AnalyticsClientProtocol
    private let appSettings: AppSettings
    private let bugReportService: BugReportServiceProtocol
    
    /// A signpost client for performance testing the app. This client doesn't respect the
    /// `isRunning` state or behave any differently when `start`/`reset` are called.
    let signpost = Signposter()

    init(client: AnalyticsClientProtocol, appSettings: AppSettings, bugReportService: BugReportServiceProtocol) {
        self.client = client
        self.appSettings = appSettings
        self.bugReportService = bugReportService
    }
        
    /// Whether or not the object is enabled and sending events to the server.
    var isRunning: Bool { client.isRunning }
    
    /// Whether to show the user the analytics opt in prompt.
    var shouldShowAnalyticsPrompt: Bool {
        // Only show the prompt once, and when analytics are enabled in BuildSettings.
        appSettings.analyticsConsentState == .unknown && appSettings.analyticsConfiguration.isEnabled
    }
    
    var isEnabled: Bool {
        appSettings.analyticsConsentState == .optedIn
    }
    
    /// Opts in to analytics tracking with the supplied user session.
    func optIn() {
        appSettings.analyticsConsentState = .optedIn
        startIfEnabled()
    }
    
    /// Stops analytics tracking and calls `reset` to clear any IDs and event queues.
    func optOut() {
        appSettings.analyticsConsentState = .optedOut
        
        // The order is important here. PostHog ignores the reset if stopped.
        reset()
        client.stop()
        bugReportService.stop()
        MXLog.info("Stopped.")
    }
    
    /// Starts the analytics client if the user has opted in, otherwise does nothing.
    func startIfEnabled() {
        guard isEnabled, !isRunning else { return }
        
        client.start(analyticsConfiguration: appSettings.analyticsConfiguration)
        bugReportService.start()

        // Sanity check in case something went wrong.
        guard client.isRunning else { return }
        
        MXLog.info("Started.")
    }
    
    /// Resets the any IDs and event queues in the analytics client. This method should
    /// be called on sign-out to maintain opt-in status, whilst ensuring the next
    /// account used isn't associated with the previous one.
    /// Note: **MUST** be called before stopping PostHog or the reset is ignored.
    func reset() {
        client.reset()
        bugReportService.reset()
        MXLog.info("Reset.")
    }
    
    /// Reset the consent state for analytics
    func resetConsentState() {
        MXLog.warning("Resetting consent state for analytics.")
        appSettings.analyticsConsentState = .unknown
    }
    
    /// Flushes the event queue in the analytics client, uploading all pending events.
    /// Normally events are sent in batches. Call this method when you need an event
    /// to be sent immediately.
    func forceUpload() {
        client.flush()
    }
    
    // MARK: - Private
    
    /// Capture an event in the `client`.
    /// - Parameter event: The event to capture.
    private func capture(event: AnalyticsEventProtocol) {
        MXLog.debug("\(event)")
        client.capture(event)
    }
}

// MARK: - Public tracking methods

extension AnalyticsService {
    /// Track the presentation of a screen
    /// - Parameter screen: The screen that was shown
    /// - Parameter duration: An optional value representing how long the screen was shown for in milliseconds.
    func track(screen: AnalyticsScreen, duration milliseconds: Int? = nil) {
        MXLog.debug("\(screen)")
        let event = AnalyticsEvent.MobileScreen(durationMs: milliseconds, screenName: screen.screenName)
        client.screen(event)
    }

    /// Track the creation of a room
    /// - Parameter isDM: true if the created room is a direct message, false otherwise
    func trackCreatedRoom(isDM: Bool) {
        capture(event: AnalyticsEvent.CreatedRoom(isDM: isDM))
    }
    
    /// Track the composer
    /// - Parameters:
    ///   - inThread: whether the composer is used in a Thread
    ///   - isEditing: whether the composer is used to edit a message
    ///   - isReply: whether the composer is used to reply a message
    ///   - messageType: the type of the message
    ///   - startsThread: whether the composer is used to start a new thread
    func trackComposer(inThread: Bool,
                       isEditing: Bool,
                       isReply: Bool,
                       messageType: AnalyticsMessageType = .text,
                       startsThread: Bool?) {
        capture(event: AnalyticsEvent.Composer(inThread: inThread,
                                               isEditing: isEditing,
                                               isReply: isReply,
                                               messageType: .init(messageType),
                                               startsThread: startsThread))
    }
    
    /// Track the presentation of a room
    /// - Parameters:
    ///   - isDM: whether the room is a direct message
    ///   - isSpace: whether the room is a space
    func trackViewRoom(isDM: Bool, isSpace: Bool) {
        capture(event: AnalyticsEvent.ViewRoom(activeSpace: nil, isDM: isDM, isSpace: isSpace, trigger: nil, viaKeyboard: nil))
    }
    
    /// Track the action of joining a room
    /// - Parameters:
    ///   - isDM: whether the room is a direct message
    ///   - isSpace: whether the room is a space
    ///   - activeMemberCount: the number of active members in the room
    func trackJoinedRoom(isDM: Bool, isSpace: Bool, activeMemberCount: UInt) {
        guard let roomSize = AnalyticsEvent.JoinedRoom.RoomSize(memberCount: activeMemberCount) else {
            MXLog.error("invalid room size")
            return
        }
        capture(event: AnalyticsEvent.JoinedRoom(isDM: isDM, isSpace: isSpace, roomSize: roomSize, trigger: nil))
    }

    /// Track the action of creating a poll
    /// - Parameters:
    ///   - isUndisclosed: whether the poll is undisclosed
    ///   - numberOfAnswers: the number of options in the poll
    func trackPollCreated(isUndisclosed: Bool, numberOfAnswers: Int) {
        capture(event: AnalyticsEvent.PollCreation(action: .Create,
                                                   isUndisclosed: isUndisclosed,
                                                   numberOfAnswers: numberOfAnswers))
    }

    /// Track the action of voting on a poll
    func trackPollVote() {
        capture(event: AnalyticsEvent.PollVote(doNotUse: nil))
    }

    /// Track the action of ending a poll
    func trackPollEnd() {
        capture(event: AnalyticsEvent.PollEnd(doNotUse: nil))
    }
}
