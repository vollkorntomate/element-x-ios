## Changes in 1.3.3 (2023-10-12)

🚧 In development 🚧

- Initial setup for PIN/Biometric app lock. ([#1876](https://github.com/vector-im/element-x-ios/pull/1876))


## Changes in 1.3.2 (2023-10-10)

✨ Features

- Tapping on matrix room id link brings you to that room. ([#1853](https://github.com/vector-im/element-x-ios/pull/1853))
- User mentions pills (behind a Feature Flag). ([#1804](https://github.com/vector-im/element-x-ios/issues/1804))
- Added the user suggestions view when trying to mention a user (but it doesn't react to tap yet). ([#1826](https://github.com/vector-im/element-x-ios/issues/1826))
- @room mention pill, and own mentions are red. ([#1829](https://github.com/vector-im/element-x-ios/issues/1829))
- Implement /me ([#1841](https://github.com/vector-im/element-x-ios/issues/1841))
- Report rust tracing configuration filter in rageshakes ([#1861](https://github.com/vector-im/element-x-ios/issues/1861))

🙌 Improvements

- Use a universal link for OIDC callbacks. ([#1734](https://github.com/vector-im/element-x-ios/issues/1734))

🐛 Bugfixes

- Add remaining iOS 17 introspections. ([#1798](https://github.com/vector-im/element-x-ios/issues/1798))
- Redirect universal links directly to the browser if they're not supported ([#1824](https://github.com/vector-im/element-x-ios/issues/1824))
- Fix message forwarding room list filtering and pagination problems ([#1864](https://github.com/vector-im/element-x-ios/issues/1864))


## Changes in 1.3.1 (2023-09-27)

🙌 Improvements

- Removed the `Reply in Thread` string in the swipe to reply action. ([#1795](https://github.com/vector-im/element-x-ios/pull/1795))
- Update icons to use Compound in more places (bundling some that aren't yet prepared as tokens). ([#1706](https://github.com/vector-im/element-x-ios/issues/1706))


## Changes in 1.3.0 (2023-09-20)

No significant changes.


## Changes in 1.2.9 (2023-09-18)

✨ Features

- Messages that are part of a thread will be marked with a thread decorator. ([#1686](https://github.com/vector-im/element-x-ios/issues/1686))
- Introduce a new advanced settings screen ([#1699](https://github.com/vector-im/element-x-ios/issues/1699))

🙌 Improvements

- Revert to using a Web Authentication Session for OIDC account management. ([#1634](https://github.com/vector-im/element-x-ios/pull/1634))
- Hook up universal links to the App Coordinator (this doesn't actually handle them yet). ([#1638](https://github.com/vector-im/element-x-ios/pull/1638))
- Separate Manage account from Manage devices ([#1698](https://github.com/vector-im/element-x-ios/pull/1698))
- Update app icon. ([#1720](https://github.com/vector-im/element-x-ios/pull/1720))
- Enable token refresh in the NSE (and notifications for OIDC accounts). ([#1712](https://github.com/vector-im/element-x-ios/issues/1712))

🐛 Bugfixes

- Add default schemes for detected links that don't have any ([#1651](https://github.com/vector-im/element-x-ios/pull/1651))
- The bloom does not pop in but fades in. ([#1705](https://github.com/vector-im/element-x-ios/pull/1705))
- Various accessibility fixes: add labels on timeline media, hide swipe to reply button, add sender on all messages, improve replies and reactions ([#1104](https://github.com/vector-im/element-x-ios/issues/1104))
-  ([#1198](https://github.com/vector-im/element-x-ios/issues/1198))
- Add copy permalink option for messages that failed decryption ([#1338](https://github.com/vector-im/element-x-ios/issues/1338))
- Viewing reaction details UI fails to switch between multiple reactions ([#1552](https://github.com/vector-im/element-x-ios/issues/1552))
- Add missing contacts field to OIDC configuration. ([#1653](https://github.com/vector-im/element-x-ios/issues/1653))
- Fix avatar button size and make mxid copyable in Room/Member details screens. ([#1669](https://github.com/vector-im/element-x-ios/issues/1669))
- Correctly parse markdown and html received in push notifications ([#1679](https://github.com/vector-im/element-x-ios/issues/1679))


## Changes in 1.2.8 (2023-09-01)

🙌 Improvements

- New avatar colouring + username colouring. ([#1603](https://github.com/vector-im/element-x-ios/issues/1603))

🐛 Bugfixes

- Fix the size of the generated thumbnail when uploading media ([#980](https://github.com/vector-im/element-x-ios/issues/980))
- Avatar colouring is aligned to web. ([#1345](https://github.com/vector-im/element-x-ios/issues/1345))


## Changes in 1.2.7 (2023-08-31)

🙌 Improvements

- Use Safari for OIDC account management. ([#1591](https://github.com/vector-im/element-x-ios/pull/1591))
- New room button has been moved to the top. ([#1602](https://github.com/vector-im/element-x-ios/issues/1602))

🐛 Bugfixes

- Improve timestamp rendering when mixed LTR and RTL languages are present in the message. ([#1539](https://github.com/vector-im/element-x-ios/pull/1539))
- Fixed a bug that made the spring board crash when trying to mute notifications. ([#1519](https://github.com/vector-im/element-x-ios/issues/1519))
- Add app logo and fix terms link for OIDC login (only affects fresh app installs). ([#1547](https://github.com/vector-im/element-x-ios/issues/1547))
- Fixed a bug that made a magnifying glass appear when long pressing a message. ([#1581](https://github.com/vector-im/element-x-ios/issues/1581))


## Changes in 1.2.6 (2023-08-22)

✨ Features

- Enable OIDC support, with notification content disabled for now. ([#261](https://github.com/vector-im/element-x-ios/issues/261))

🐛 Bugfixes

- Fix for voice over reading braille dot at the end of a message. ([#1538](https://github.com/vector-im/element-x-ios/pull/1538))


## Changes in 1.2.5 (2023-08-18)

No significant changes.


## Changes in 1.2.4 (2023-08-18)

✨ Features

- Allow fuzzy searching for room list rooms ([#1483](https://github.com/vector-im/element-x-ios/pull/1483))

🙌 Improvements

- Use Compound ListRow instead of .xyzStyle(.compoundRow) ([#1484](https://github.com/vector-im/element-x-ios/pull/1484))


## Changes in 1.2.3 (2023-08-10)

✨ Features

- Re-enabled background app refreshes ([#1462](https://github.com/vector-im/element-x-ios/pull/1462))
- Re-enabled the room list cache and offline mode support ([#1461](https://github.com/vector-im/element-x-ios/issues/1461))

🐛 Bugfixes

- Fixed crash when trying to reply to media files ([#1472](https://github.com/vector-im/element-x-ios/pull/1472))
- Prevent inconsistent view hierarchies when opening rooms from push notifications ([#1140](https://github.com/vector-im/element-x-ios/issues/1140))
- Preserve new lines within the same paragraph when parsing html strings ([#1463](https://github.com/vector-im/element-x-ios/issues/1463))


## Changes in 1.2.2 (2023-08-08)

✨ Features

- Display avatars full screen when tapping on them from the room or member detail screens ([#1448](https://github.com/vector-im/element-x-ios/pull/1448))

🐛 Bugfixes

- Fix a bug where media previews would sometimes dismiss to show the timeline with a big empty space at the bottom. ([#1428](https://github.com/vector-im/element-x-ios/pull/1428))
- Send read receipts as messages are displayed instead of on opening/closing rooms. ([#639](https://github.com/vector-im/element-x-ios/issues/639))

🧱 Build

- Make CI upload dSyms to Sentry before releasing to GitHub to avoid tagging failed runs. ([#1457](https://github.com/vector-im/element-x-ios/pull/1457))


## Changes in 1.2.1 (2023-08-01)

✨ Features

- Location sharing: view and send static locations. ([#1358](https://github.com/vector-im/element-x-ios/pull/1358))
- Timeline animations. ([#1371](https://github.com/vector-im/element-x-ios/pull/1371))
- Send current user location ([#1272](https://github.com/vector-im/element-x-ios/issues/1272))
- Contact Me switch added to the Bug Report screen. ([#1299](https://github.com/vector-im/element-x-ios/issues/1299))

🙌 Improvements

- Update Room Details to use compound styles everywhere. ([#1369](https://github.com/vector-im/element-x-ios/pull/1369))
- Tweaks for macOS only: Fix Create Room button animation bug / Restore the timeline context menu / Fix media upload preview obscuring send button. ([#1383](https://github.com/vector-im/element-x-ios/pull/1383))
- Make the app version and the device ID copyable in the Settings screen. ([#623](https://github.com/vector-im/element-x-ios/issues/623))

🐛 Bugfixes

- Fix for UI not retaining blocked/unlocked user state after dismissing and re-entering the details from the room member list. ([#910](https://github.com/vector-im/element-x-ios/issues/910))
- Added an FF to enable push rules filtering. Also invitation notifications will now be always displayed reliably. ([#1172](https://github.com/vector-im/element-x-ios/issues/1172))
- Compute correct sizes for portrait videos ([#1262](https://github.com/vector-im/element-x-ios/issues/1262))
- Push notifications for a room are cleared from the notification centre when opening its timeline. Same for invitations when opening the invite screen. ([#1277](https://github.com/vector-im/element-x-ios/issues/1277))
- Fixed wrong icon for files in replies. ([#1319](https://github.com/vector-im/element-x-ios/issues/1319))
- Moderators can now remove other people messages if they have permission in non direct rooms. ([#1321](https://github.com/vector-im/element-x-ios/issues/1321))

🧱 Build

- Don't upgrade more homebrew deps than needed on GitHub runners. ([#1374](https://github.com/vector-im/element-x-ios/pull/1374))
- Specify the target for code coverage in the Integration Tests plan. ([#1398](https://github.com/vector-im/element-x-ios/pull/1398))


## Changes in 1.1.8 (2023-07-05)

✨ Features

- Added a welcome screen that will appear only once. ([#1259](https://github.com/vector-im/element-x-ios/pull/1259))

🙌 Improvements

- Reduce horizonal message bubble padding when the avatar isn't shown ([#1233](https://github.com/vector-im/element-x-ios/pull/1233))
- Push notifications will be displayed as DM only in direct rooms where joined members are at most 2. ([#1205](https://github.com/vector-im/element-x-ios/issues/1205))
- Add encryption history banner. ([#1251](https://github.com/vector-im/element-x-ios/issues/1251))

🐛 Bugfixes

- Caching for the notification placeholder image, to avoid generating it too many times and taking too much memory. ([#1243](https://github.com/vector-im/element-x-ios/issues/1243))


## Changes in 1.1.7 (2023-06-30)

✨ Features

- Push Notifications of rooms/dm without avatars will now display the default placeholder used in app. ([#1168](https://github.com/vector-im/element-x-ios/issues/1168))
- Send pin-drop location ([#1179](https://github.com/vector-im/element-x-ios/issues/1179))

🙌 Improvements

- Improve media preview presentation and interaction in the timeline. ([#1187](https://github.com/vector-im/element-x-ios/pull/1187))
- Update long press gesture animation ([#1195](https://github.com/vector-im/element-x-ios/pull/1195))
- Failed local echoes can be edited, they will just get cancelled and resent with the new content. ([#1207](https://github.com/vector-im/element-x-ios/pull/1207))
- Show a migration screen on the first use of the app whilst the proxy does an initial sync. ([#983](https://github.com/vector-im/element-x-ios/issues/983))
- Delivery status is now displayed only for the last outgoing message. ([#1101](https://github.com/vector-im/element-x-ios/issues/1101))
- Filter out some message actions and reactions for failed local echoes and redacted messages. ([#1151](https://github.com/vector-im/element-x-ios/issues/1151))

🐛 Bugfixes

- Messages that have failed to be decrypted are show only view source and retry decryptions as possible actions. ([#1185](https://github.com/vector-im/element-x-ios/issues/1185))
- Fix for the flipped notification image placeholder on iOS. ([#1194](https://github.com/vector-im/element-x-ios/issues/1194))


## Changes in 1.1.5 (2023-06-26)

✨ Features

- Add analytics tracking for room creation ([#1100](https://github.com/vector-im/element-x-ios/pull/1100))
- Added support for message forwarding ([#978](https://github.com/vector-im/element-x-ios/issues/978))
- Failed to send messages can now be either retried or removed by tapping on the error icon/timestamp. ([#979](https://github.com/vector-im/element-x-ios/issues/979))
- Add MapLibre SDK and the Map View component ([#1062](https://github.com/vector-im/element-x-ios/issues/1062))
- Two sync loop implementation to allow to fetch and update decryption keys also from the NSE. ([#1083](https://github.com/vector-im/element-x-ios/issues/1083))
- Add reverse geocoding request, that for a given coordinate will return the place name. ([#1085](https://github.com/vector-im/element-x-ios/issues/1085))
- Add analytics events. ([#1097](https://github.com/vector-im/element-x-ios/issues/1097))
- Filtering out push notifications for encrypted rooms based on the room push context. ([#1114](https://github.com/vector-im/element-x-ios/issues/1114))
- Add static map url builder and static map UI component with placeholder and reload logic ([#1115](https://github.com/vector-im/element-x-ios/issues/1115))
- Render emote notifications like in the timeline ([#1117](https://github.com/vector-im/element-x-ios/issues/1117))

🙌 Improvements

- Migrate all colour tokens to use Compound and deprecate DesignKit tokens. ([#732](https://github.com/vector-im/element-x-ios/issues/732))
- General app polish. ([#1036](https://github.com/vector-im/element-x-ios/issues/1036))
- Refactored AlertInfo to not use the soon to be deprecated API for alerts anymore. ([#1067](https://github.com/vector-im/element-x-ios/issues/1067))
- Add a screen to be shown when new users are on the waiting list. ([#1154](https://github.com/vector-im/element-x-ios/issues/1154))

🐛 Bugfixes

- Fixed crashes when opening the invites screen ([#1102](https://github.com/vector-im/element-x-ios/issues/1102))
- Disabled push rules filtering temporarily to fix a bug that prevented push notifications from being received. ([#1155](https://github.com/vector-im/element-x-ios/issues/1155))
- Handled the cancelled state of a message properly as a failure state. ([#1160](https://github.com/vector-im/element-x-ios/issues/1160))


## Changes in 1.1.4 (2023-06-13)

🐛 Bugfixes

- Fixed crashes when trying to save media to the photo library ([#1072](https://github.com/vector-im/element-x-ios/issues/1072))


## Changes in 1.1.3 (2023-06-12)

✨ Features

- Timestamp added to non bubbled messages like images and videos for bubble style. ([#1057](https://github.com/vector-im/element-x-ios/pull/1057))
- Read Receipts with avatars will be displayed at the bottom of the messages (only for Nightly, can be enabled in developer settings). ([#1052](https://github.com/vector-im/element-x-ios/issues/1052))

🐛 Bugfixes

- Improved timestamp rendering for RTL and bidirectional mixed text. ([#1055](https://github.com/vector-im/element-x-ios/pull/1055))


## Changes in 1.1.2 (2023-06-08)

✨ Features

- Timestamp for messages incorporated in a bubble. ([#948](https://github.com/vector-im/element-x-ios/issues/948))
- Add the image picker flow for the creation of a room ([#961](https://github.com/vector-im/element-x-ios/issues/961))
- Update reply composer mode UI to include message being replied to ([#976](https://github.com/vector-im/element-x-ios/issues/976))
- Added an `About` section and links to legal information in the application settings ([#1011](https://github.com/vector-im/element-x-ios/issues/1011))
- Tapping on a user avatar/name in the timeline opens the User Details view for that user. ([#1017](https://github.com/vector-im/element-x-ios/issues/1017))

🙌 Improvements

- Improve bug report uploads with file size checks and better error handling. ([#1018](https://github.com/vector-im/element-x-ios/pull/1018))
- Showing the iOS default contact/group silhouette in notifications when the avatar is missing. ([#965](https://github.com/vector-im/element-x-ios/pull/965))

🐛 Bugfixes

- Update PostHog to 2.0.3 to fix the app's accent colour. ([#1006](https://github.com/vector-im/element-x-ios/pull/1006))
- Fix an incorrect colour when replying to a message in dark mode. ([#1007](https://github.com/vector-im/element-x-ios/pull/1007))
- Prevent room navigation back button from jumping while animating ([#945](https://github.com/vector-im/element-x-ios/pull/945))

⚠️ API Changes

- Bump the minimum supported iOS version to 16.4. ([#994](https://github.com/vector-im/element-x-ios/pull/994))


## Changes in 1.1.1 (2023-05-23)

✨ Features

- Redesigned the delivery status icon. ([#921](https://github.com/vector-im/element-x-ios/issues/921))
- Add creation of a room, fetching the summary, so the room will be ready to be presented. ([#925](https://github.com/vector-im/element-x-ios/issues/925))

🐛 Bugfixes

- Stopping bg task when the app is suspended and the slidingSyncObserver is finished. ([#438](https://github.com/vector-im/element-x-ios/issues/438))
- Added the context menu to the plain style. ([#686](https://github.com/vector-im/element-x-ios/issues/686))


## Changes in 1.1.0 (2023-05-18)

✨ Features

- Add the entry point for the Start a new Chat flow, with button on home Screen and first page ([#680](https://github.com/vector-im/element-x-ios/pull/680))
- Show or create direct message room ([#716](https://github.com/vector-im/element-x-ios/pull/716))
- Add background app refresh support ([#892](https://github.com/vector-im/element-x-ios/pull/892))
- Adopt compound-ios on the Settings and Bug Report screens. ([#43](https://github.com/vector-im/element-x-ios/issues/43))
- Set up Analytics to track data. ([#106](https://github.com/vector-im/element-x-ios/issues/106))
- Add Localazy to the project for strings. ([#124](https://github.com/vector-im/element-x-ios/issues/124))
- Add user search when creating a new dm room. ([#593](https://github.com/vector-im/element-x-ios/issues/593))
- Add invites list (UI only) ([#605](https://github.com/vector-im/element-x-ios/issues/605))
- Users can accept and decline invites. ([#621](https://github.com/vector-im/element-x-ios/issues/621))
- Added unread badges in the invites list. ([#714](https://github.com/vector-im/element-x-ios/issues/714))
- Added the Room Member Details Screen. ([#723](https://github.com/vector-im/element-x-ios/issues/723))
- Ignore User functionality added in the Room Member Details View. ([#733](https://github.com/vector-im/element-x-ios/issues/733))
- Added DM Details View. ([#738](https://github.com/vector-im/element-x-ios/issues/738))
- Enabled Push Notifications with static text. ([#759](https://github.com/vector-im/element-x-ios/issues/759))
- Select members before creating a room (UI for selection) ([#766](https://github.com/vector-im/element-x-ios/issues/766))
- Local notifications support, these can also be decrypted and shown as rich push notifications. ([#813](https://github.com/vector-im/element-x-ios/issues/813))
- Remote Push Notifications can now be displayed as rich push notifications. ([#855](https://github.com/vector-im/element-x-ios/issues/855))
- Create a room screen (UI only) ([#877](https://github.com/vector-im/element-x-ios/issues/877))

🙌 Improvements

- Bump the SDK version and fix breaking changes. ([#703](https://github.com/vector-im/element-x-ios/pull/703))
- Updated dependencies, and added a tool to check for outdated ones. ([#721](https://github.com/vector-im/element-x-ios/pull/721))
- Add test plans for other test targets. ([#740](https://github.com/vector-im/element-x-ios/pull/740))
- change name to nil in direct room parameters ([#758](https://github.com/vector-im/element-x-ios/pull/758))
- Guard user suggestions behind feature flag so that they don't impact releasability of other room creation features ([#770](https://github.com/vector-im/element-x-ios/pull/770))
- Remove styling for developer toggles ([#771](https://github.com/vector-im/element-x-ios/pull/771))
- Use iOS localization handling for strings. ([#803](https://github.com/vector-im/element-x-ios/pull/803))
- Analytics: reset user's consents on logout. ([#816](https://github.com/vector-im/element-x-ios/pull/816))
- Use the existing quote bubble layout with TimelineReplyView. ([#883](https://github.com/vector-im/element-x-ios/pull/883))
- Use Compound fonts everywhere. Allow the search bar to be styled. ([#43](https://github.com/vector-im/element-x-ios/issues/43))
- Add Block user toggle to Report Content screen. ([#115](https://github.com/vector-im/element-x-ios/issues/115))
- Migrate strings to Localazy, remove Android strings and use UntranslatedL10n to be clear when strings won't be translated. ([#124](https://github.com/vector-im/element-x-ios/issues/124))
- Move media file loading logic to the SDK. ([#316](https://github.com/vector-im/element-x-ios/issues/316))
- Bump SDK version and fix breaking changes. ([#709](https://github.com/vector-im/element-x-ios/issues/709))
- Animations are disabled when tapping on an animations when the app is in background. ([#776](https://github.com/vector-im/element-x-ios/issues/776))
- Removed the about title copy from the people section. ([#777](https://github.com/vector-im/element-x-ios/issues/777))
- Move search users into UserProvider service ([#789](https://github.com/vector-im/element-x-ios/issues/789))

🐛 Bugfixes

- Hides the scroll down button for VoiceOver users if it is hidden for visual users by Sem Pruijs ([#670](https://github.com/vector-im/element-x-ios/pull/670))
- Hide the avatars when the users has larger font on by Sem Pruijs ([#690](https://github.com/vector-im/element-x-ios/pull/690))
- Hide the message composer textfield placeholder for VoiceOver users by Sem Pruijs ([#695](https://github.com/vector-im/element-x-ios/pull/695))
- Fix incorrect state string. ([#704](https://github.com/vector-im/element-x-ios/pull/704))
- Use a local copy of the accent colour in the asset catalog so it is applied to Alerts, Xcode previews etc. ([#43](https://github.com/vector-im/element-x-ios/issues/43))
- Fix all broken snapshot tests follow strings update. Use double-length pseudolanguage instead of German to avoid translators breaking tests. ([#124](https://github.com/vector-im/element-x-ios/issues/124))
- Fixed room previews failing to load because of incorrect sliding sync view ranges ([#641](https://github.com/vector-im/element-x-ios/issues/641))
- Fixed room list not loading in offline mode ([#676](https://github.com/vector-im/element-x-ios/issues/676))
- Fixed incorrect link detection and handling in the timeline ([#687](https://github.com/vector-im/element-x-ios/issues/687))
- Fixed a bug that prevented the right localisation to be used when the preferred language locale contained a region identifier. ([#764](https://github.com/vector-im/element-x-ios/issues/764))
- Fixed a bug that crashed the app when tapping on push notifications while the app was in some specific unhandled screens. ([#779](https://github.com/vector-im/element-x-ios/issues/779))
- Display the room list even if the room count is not exact. ([#796](https://github.com/vector-im/element-x-ios/issues/796))
- Notifications are now handled when the app is in a killed state. ([#802](https://github.com/vector-im/element-x-ios/issues/802))
- Fixed a bug that did not render the sender icon of a dm sometimes. ([#863](https://github.com/vector-im/element-x-ios/issues/863))

📄 Documentation

- Update the link of the element ios room to be the element x ios support room in CONTRIBUTING.md and README.md by Sem Pruijs ([#668](https://github.com/vector-im/element-x-ios/pull/668))

🚧 In development 🚧

- Remove AppAuth library and prepare for Rust OIDC. ([#261](https://github.com/vector-im/element-x-ios/issues/261))


## Changes in 1.0.24 (2023-03-10)

✨ Features

- Auto Mocks generator added to the project. ([#600](https://github.com/vector-im/element-x-ios/issues/600))

🙌 Improvements

- Improved report content UI. ([#115](https://github.com/vector-im/element-x-ios/issues/115))
- Avatar url is now cached on the rust side. ([#550](https://github.com/vector-im/element-x-ios/issues/550))

🐛 Bugfixes

- Fixed crash on the settings screen when showing the "complete verification" button before the session verification controller proxy was ready ([#650](https://github.com/vector-im/element-x-ios/pull/650))
- Ignore background images in OnboardingBackgroundView for VoiceOver users by Sem Pruijs ([#658](https://github.com/vector-im/element-x-ios/pull/658))
- Hide the message composer textfield placeholder for VoiceOver users by Sem Pruijs ([#688](https://github.com/vector-im/element-x-ios/pull/688))
- Hides the scroll down button for VoiceOver users if it is hidden for visual users by Sem Pruijs (pr670)
- Prevent creating collapsible groups for one single event. Increase their padding and touch area. ([#631](https://github.com/vector-im/element-x-ios/issues/631))
- Update top padding and a string in Login and Server Selection screens. ([#632](https://github.com/vector-im/element-x-ios/issues/632))

⚠️ API Changes

- Remove all APIs that load media from URLs. These were unused and we should continue to load media through MediaSource in the future. ([#444](https://github.com/vector-im/element-x-ios/issues/444))


## Changes in 1.0.23 (2023-02-24)

No significant changes.


## Changes in 1.0.22 (2023-02-24)

No significant changes.


## Changes in 1.0.21 (2023-02-23)

✨ Features

- Added a feature that allows a user to report content posted by another user by opening the context menu and provide a reason. ([#115](https://github.com/vector-im/element-x-ios/issues/115))
- Added support for audio messages in the timeline as previewable files. ([#594](https://github.com/vector-im/element-x-ios/issues/594))

🐛 Bugfixes

- Fix broken split layout room navigation ([#613](https://github.com/vector-im/element-x-ios/pull/613))


## Changes in 1.0.20 (2023-02-22)

✨ Features

- Enable auto-discovery of sliding sync proxy, directing users to more information when their server doesn't support it. ([#410](https://github.com/vector-im/element-x-ios/issues/410))

🙌 Improvements

- Added the functionality to attach a screenshot in the Bug Report View. ([#127](https://github.com/vector-im/element-x-ios/issues/127))
- Added associated domains applinks. ([#301](https://github.com/vector-im/element-x-ios/issues/301))
- Add missing shimmer effect on home screen and tweak the message composer. ([#430](https://github.com/vector-im/element-x-ios/issues/430))
- Added a progress bar to to the bug report screen, when sending the report. ([#495](https://github.com/vector-im/element-x-ios/issues/495))
- Launch UI tests directly in the screen that will be tested and type character by character instead of retrying. ([#534](https://github.com/vector-im/element-x-ios/issues/534))
- Removed reply/edit dimming for all non highlighted messages to increase readability. ([#542](https://github.com/vector-im/element-x-ios/issues/542))
- Refactored UserNotification into UserIndicator. ([#547](https://github.com/vector-im/element-x-ios/issues/547))
- Update appearance of forms in the app. Add formBackground and formRowBackground colours. ([#565](https://github.com/vector-im/element-x-ios/issues/565))
- Rename SettingsRow… to Form…Style and use these everywhere (sparingly on the Bug Report Screen which isn't a real form). ([#602](https://github.com/vector-im/element-x-ios/issues/602))

🐛 Bugfixes

- Allow blockquote bubbles to fill the message bubble ([#527](https://github.com/vector-im/element-x-ios/pull/527))
- Fixed and updated some UI Tests. ([#554](https://github.com/vector-im/element-x-ios/pull/554))
- Fix incorrect visible room ranges: correctly remove duplicates and ignore appearance changes while filtering ([#603](https://github.com/vector-im/element-x-ios/pull/603))
- Fixed incorrect link detection on messages containing emojis ([#464](https://github.com/vector-im/element-x-ios/issues/464))
- Context Menu Crash: Attempted fix by explicitly passing in the context to each cell. ([#532](https://github.com/vector-im/element-x-ios/issues/532))
- Fix UI Tests for OnboardingScreen, BugReportScreen, ServerSelectionScreen, and UserSessionFlows. Fix UITestsSignalling by switching to file-based communication with a publisher. ([#534](https://github.com/vector-im/element-x-ios/issues/534))
- Fix the background colour of the room members screen in dark mode. ([#583](https://github.com/vector-im/element-x-ios/issues/583))
- Make sure forms have pressed states, remove incorrect disclosure indicators, stop login screen placeholders from flickering and don't block the loging screen when parsing a username. ([#602](https://github.com/vector-im/element-x-ios/issues/602))

🧱 Build

- Update PR Build workflow triggers. ([#564](https://github.com/vector-im/element-x-ios/pull/564))
- Update SwiftLint and SwiftFormat rules. ([#579](https://github.com/vector-im/element-x-ios/pull/579))


## Changes in 1.0.18 (2023-02-03)

No significant changes.


## Changes in 1.0.17 (2023-02-03)

🙌 Improvements

- Hardcode the sliding sync proxy to matrix.org for FOSDEM demo. ([#502](https://github.com/vector-im/element-x-ios/pull/502))
- Add different states for a room's last message to distinguish loading from loaded from unknown. ([#514](https://github.com/vector-im/element-x-ios/pull/514))
- Finish the design review ready for a public TestFlight. ([#430](https://github.com/vector-im/element-x-ios/issues/430))

🐛 Bugfixes

- Fixed a bug that recognised any amount in dollars as an untappable link. ([#500](https://github.com/vector-im/element-x-ios/issues/500))


## Changes in 1.0.15 (2023-01-26)

🙌 Improvements

- Add support for aliases to RoomProxy and bump the SDK version. ([#486](https://github.com/vector-im/element-x-ios/pull/486))

🐛 Bugfixes

- Show the date instead of the time in the room list when the last message is from yesterday or before. ([#484](https://github.com/vector-im/element-x-ios/pull/484))
- Prevent room timelines from becoming stale if the room drops out of the sliding sync window ([#448](https://github.com/vector-im/element-x-ios/issues/448))

🚧 In development 🚧

- Design update for first public TestFlight ([#430](https://github.com/vector-im/element-x-ios/issues/430))


## Changes in 1.0.14 (2023-01-20)

✨ Features

- Show state events in the timeline and (at least temporarily) on the home screen. ([#473](https://github.com/vector-im/element-x-ios/pull/473))

🙌 Improvements

- Logging: Redact Room/Message content and use MXLog.info in more places. ([#457](https://github.com/vector-im/element-x-ios/pull/457))
- Rooms: Mark rooms as read when opening/closing. ([#414](https://github.com/vector-im/element-x-ios/issues/414))

🐛 Bugfixes

- Prevent long room names from breaking the room navigation bar layout ([#388](https://github.com/vector-im/element-x-ios/issues/388))
- Fix room member details screen performance ([#421](https://github.com/vector-im/element-x-ios/issues/421))

🧱 Build

- DesignKit: Move into a sub-package as long term this package will live outside of this repo. ([#459](https://github.com/vector-im/element-x-ios/pull/459))


## Changes in 1.0.13 (2023-01-13)

✨ Features

- Add support for manually starting SaS verification flows and accepting remotely started ones ([#408](https://github.com/vector-im/element-x-ios/pull/408))
- Add support for new timeline items: loading indicators, stickers, invalid events and begining of history ([#424](https://github.com/vector-im/element-x-ios/pull/424))

🙌 Improvements

- Add MediaProvider tests. ([#386](https://github.com/vector-im/element-x-ios/pull/386))
- UserSession: Add unit tests. ([#390](https://github.com/vector-im/element-x-ios/pull/390))
- Use the links colour from Compound for links and avoid recomputing the RoomScreen view hierarchy while scrolling. ([#406](https://github.com/vector-im/element-x-ios/pull/406))
- Notification Manager: Replace completion handlers with async/await. ([#407](https://github.com/vector-im/element-x-ios/pull/407))
- Use QuickLook previews for video and present previews full screen (doesn't address gestures yet). ([#418](https://github.com/vector-im/element-x-ios/issues/418))

🐛 Bugfixes

- Use pagination indicators and start of room timeline items to update the view's pagination state. ([#432](https://github.com/vector-im/element-x-ios/pull/432))
- Prevent crash popups when force quitting the application ([#437](https://github.com/vector-im/element-x-ios/pull/437))
- Wait for logout confirmation before changing the app state ([#340](https://github.com/vector-im/element-x-ios/issues/340))
- Migrate and store session data in Application Support instead of Caches ([#389](https://github.com/vector-im/element-x-ios/issues/389))
- Video playback: Fix playback of encrypted video files. ([#419](https://github.com/vector-im/element-x-ios/issues/419))

🧱 Build

- UI Tests: Remove the French locale from the tests. ([#420](https://github.com/vector-im/element-x-ios/pull/420))
- Send all issues to the [EX board](https://github.com/orgs/vector-im/projects/43). ([#439](https://github.com/vector-im/element-x-ios/pull/439))


## Changes in 1.0.12 (2023-01-04)

No significant changes.


## Changes in 1.0.11 (2023-01-04)

🐛 Bugfixes

- Avoid the "Failed to load messages" popup when all messages have been loaded. ([#399](https://github.com/vector-im/element-x-ios/pull/399))
- Fix stuck timeline pagination because of too many membership events ([#394](https://github.com/vector-im/element-x-ios/issues/394))


## Changes in 1.0.10 (2022-12-22)

✨ Features

- Added timeline day separators and read markers ([#383](https://github.com/vector-im/element-x-ios/pull/383))
- Add retry decryption encrypted timeline item debug menu option ([#384](https://github.com/vector-im/element-x-ios/pull/384))
- Display an indicator if the network is currently unreachable ([#258](https://github.com/vector-im/element-x-ios/issues/258))

🐛 Bugfixes

- * moved the message delivery status outside of the main content and added it to the plain timeline as well
  * fixed glithcy scroll to bottom timeline button
  * simplified the emoji picker, double tapping a timeline item directly opens it now and added a context menu option. Linked it to rust side reaction sending
  * fixed cold cache seemingly not working (invalid rooms treated as empty)
  * made splash screen full screen
  * fixed connectivity indicator starting off as offline
  * added presentation detents on the NavigationStackCoordinator as they're not inherited from the child
  * fixed timeline item link tint colors
  * removed some unnecessary classes ([#381](https://github.com/vector-im/element-x-ios/pull/381))


## Changes in 1.0.9 (2022-12-16)

✨ Features

- Timeline: Sending and sent state for timeline messages. ([#27](https://github.com/vector-im/element-x-ios/issues/27))
- NSE: Configure target with commented code blocks. ([#243](https://github.com/vector-im/element-x-ios/issues/243))
- Timeline: Display images fullscreen when tapped. ([#244](https://github.com/vector-im/element-x-ios/issues/244))
- Implemented new SwiftUI based app navigation components ([#286](https://github.com/vector-im/element-x-ios/issues/286))
- Send messages on return. ([#314](https://github.com/vector-im/element-x-ios/issues/314))
- Implemented new user notification components on top of SwiftUI and the new navigation flows ([#315](https://github.com/vector-im/element-x-ios/issues/315))
- Implement a split screen layout for when running on iPad and MacOS ([#317](https://github.com/vector-im/element-x-ios/issues/317))
- Expose sliding sync proxy configuration URL on the server selection screen ([#320](https://github.com/vector-im/element-x-ios/issues/320))

🙌 Improvements

- Swift from a LazyVStack to a VStack for the timeline. ([#332](https://github.com/vector-im/element-x-ios/pull/332))
- Stop generating previews for light and dark colour schemes now that preview variants are a thing. ([#345](https://github.com/vector-im/element-x-ios/pull/345))
- Re-write the timeline view to be backed by a UITableView to fix scroll glitches. ([#349](https://github.com/vector-im/element-x-ios/pull/349))
- Re-write MXLogger in Swift. ([#166](https://github.com/vector-im/element-x-ios/issues/166))
- Timeline: Add a couple of basic tests to make sure the timeline is bottom aligned. ([#352](https://github.com/vector-im/element-x-ios/issues/352))

🐛 Bugfixes

- Fix a bug where the access token wasn't stored on macOS (Designed for iPad). ([#354](https://github.com/vector-im/element-x-ios/pull/354))
- Message Composer: Fix vertical padding with multiple lines of text. ([#305](https://github.com/vector-im/element-x-ios/issues/305))
- Reactions: Match alignment with the message to fix random floating reactions. ([#307](https://github.com/vector-im/element-x-ios/issues/307))
- Timeline: Fixed scrolling performance issues. ([#330](https://github.com/vector-im/element-x-ios/issues/330))
- Application: Fix background tasks & state machine crashes. ([#341](https://github.com/vector-im/element-x-ios/issues/341))

🧱 Build

- The Unit Tests workflow now fails when there are SwiftFormat errors. ([#353](https://github.com/vector-im/element-x-ios/pull/353))
- Tools: Add a command line tool to build a local copy of the SDK for debugging. ([#362](https://github.com/vector-im/element-x-ios/issues/362))

Others

- Setup tracing with a typed configuration and add some presets. ([#336](https://github.com/vector-im/element-x-ios/pull/336))


## Changes in 1.0.8 (2022-11-16)

✨ Features

- Timeline: Add playback support for video items. ([#238](https://github.com/vector-im/element-x-ios/issues/238))
- Timeline: Display file messages and preview them when tapped. ([#310](https://github.com/vector-im/element-x-ios/issues/310))

📄 Documentation

- Updated some documentation files. ([#312](https://github.com/vector-im/element-x-ios/issues/312))


## Changes in 1.0.7 (2022-11-10)

✨ Features

- Timeline: Display video messages. ([#237](https://github.com/vector-im/element-x-ios/issues/237))
- Timeline: Implement message editing via context menu. ([#252](https://github.com/vector-im/element-x-ios/issues/252))
- Added support for non-decryptable timeline items ([#291](https://github.com/vector-im/element-x-ios/issues/291))
- Added a timeline item context menu option for printing and showing their debug description ([#292](https://github.com/vector-im/element-x-ios/issues/292))

🐛 Bugfixes

- Fix identifier regexes: Fixes permalink action on timeline. ([#303](https://github.com/vector-im/element-x-ios/pull/303))
- Allow session restoration even while offline ([#239](https://github.com/vector-im/element-x-ios/issues/239))
- Timeline: Reset keyboard after a message is sent. ([#269](https://github.com/vector-im/element-x-ios/issues/269))
- Remove home screen list change animations ([#273](https://github.com/vector-im/element-x-ios/issues/273))


## Changes in 1.0.6 (2022-11-02)

🙌 Improvements

- Move Rust client operations into a dedicated concurrent queue, make sure not used on main thread. ([#283](https://github.com/vector-im/element-x-ios/pull/283))
- Rebuilt the timeline scrolling behavior on top of a more SwiftUI centric approach ([#276](https://github.com/vector-im/element-x-ios/issues/276))

🐛 Bugfixes

- Fix state machine crashes when backgrounding the app before the user session is setup ([#277](https://github.com/vector-im/element-x-ios/issues/277))
- Fixed blockquote and item layout when using the plain timeline ([#279](https://github.com/vector-im/element-x-ios/issues/279))


## Changes in 1.0.5 (2022-10-28)

✨ Features

- Enable e2e encryption support ([#274](https://github.com/vector-im/element-x-ios/pull/274))

🙌 Improvements

- Reduce code block font size and switch to SanFrancisco Monospaced ([#267](https://github.com/vector-im/element-x-ios/pull/267))
- Set a proper user agent ([#225](https://github.com/vector-im/element-x-ios/issues/225))


## Changes in 1.0.4 (2022-10-25)

🙌 Improvements

- Build with Xcode 14.0 and fix introspection on the timeline List. ([#163](https://github.com/vector-im/element-x-ios/issues/163))
- Include app name in default session display name ([#227](https://github.com/vector-im/element-x-ios/issues/227))

🐛 Bugfixes

- Fix strong reference cycle between RoomProxy and RoomTimelineProvider ([#216](https://github.com/vector-im/element-x-ios/issues/216))

📄 Documentation

- Add notes for how to debug the network traffic ([#223](https://github.com/vector-im/element-x-ios/issues/223))

Others

- Include changelog.d in Xcode project ([#218](https://github.com/vector-im/element-x-ios/issues/218))


## Changes in 1.0.3 (2022-09-23)

✨ Features

- UITests: Add screenshot tests. ([#9](https://github.com/vector-im/element-x-ios/issues/9))
- Logout from the server & implement soft logout flow. ([#104](https://github.com/vector-im/element-x-ios/issues/104))
- Implemented timeline item repyling ([#114](https://github.com/vector-im/element-x-ios/issues/114))
- Room: New bubbles design implementation. ([#177](https://github.com/vector-im/element-x-ios/issues/177))
- HomeScreen: Add user options menu to avatar and display name. ([#179](https://github.com/vector-im/element-x-ios/issues/179))
- Settings screen: Implement new design. ([#180](https://github.com/vector-im/element-x-ios/issues/180))

🙌 Improvements

- Use unstable MSC2967 values for OIDC scopes + client registration metadata updates. ([#154](https://github.com/vector-im/element-x-ios/pull/154))
- DesignKit: Update design tokens and add system colours to a local copy of ElementColors. ([#186](https://github.com/vector-im/element-x-ios/pull/186))
- DesignKit: Update fonts to match Figma. ([#187](https://github.com/vector-im/element-x-ios/pull/187))
- Include redacted events in the timeline. ([#199](https://github.com/vector-im/element-x-ios/pull/199))
- Rename RoomTimelineProviderItem to TimelineItemProxy for clarity. ([#162](https://github.com/vector-im/element-x-ios/issues/162))
- Style the session verification banner to match Figma. ([#181](https://github.com/vector-im/element-x-ios/issues/181))

🐛 Bugfixes

- Replace blocking detached tasks with Task.dispatch(on:). ([#201](https://github.com/vector-im/element-x-ios/pull/201))

🧱 Build

- Disable danger for external forks due to missing secret and run SwiftFormat as a pre-build step to fail early on CI. ([#157](https://github.com/vector-im/element-x-ios/pull/157))
- Run SwiftFormat as a post-build script locally, with an additional pre-build step on CI. ([#167](https://github.com/vector-im/element-x-ios/pull/167))
- Add validate-lfs.sh check from Element Android. ([#203](https://github.com/vector-im/element-x-ios/pull/203))
- Python 3 support for localizer script. ([#191](https://github.com/vector-im/element-x-ios/issues/191))

📄 Documentation

- CONTRIBUTING.md: Fix broken link to the `createScreen.sh` script. ([#153](https://github.com/vector-im/element-x-ios/pull/153))

🚧 In development 🚧

- Begin adding the same Analytics used in Element iOS. ([#106](https://github.com/vector-im/element-x-ios/issues/106))
- Add isEdited and reactions properties to timeline items. ([#111](https://github.com/vector-im/element-x-ios/issues/111))
- Add a redactions context menu item (disabled for now whilst waiting for SDK releases). ([#178](https://github.com/vector-im/element-x-ios/issues/178))

Others

- Add a pull request template. ([#156](https://github.com/vector-im/element-x-ios/pull/156))
- Use standard file headers. ([#150](https://github.com/vector-im/element-x-ios/issues/150))


## Changes in 1.0.2 (2022-07-28)

✨ Features

- Implement rageshake service. ([#23](https://github.com/vector-im/element-x-ios/issues/23))
- Add filtering for rooms by name. ([#26](https://github.com/vector-im/element-x-ios/issues/26))
- Settings screen minimal implementation. ([#37](https://github.com/vector-im/element-x-ios/issues/37))
- Perform password login using the Rust authentication service. ([#40](https://github.com/vector-im/element-x-ios/issues/40))
- DesignKit: Add initial implementation of DesignKit to the repo as a Swift package. ([#43](https://github.com/vector-im/element-x-ios/issues/43))
- Room timeline: Add plain styler and add timeline option in settings screen. ([#92](https://github.com/vector-im/element-x-ios/issues/92))
- Implement and use background tasks. ([#99](https://github.com/vector-im/element-x-ios/issues/99))

🙌 Improvements

- Implement new ClientBuilder pattern for login ([#120](https://github.com/vector-im/element-x-ios/pull/120))
- Flatten the room list by removing the encrypted groups. ([#121](https://github.com/vector-im/element-x-ios/pull/121))
- Add AuthenticationService and missing UI tests on the flow. ([#126](https://github.com/vector-im/element-x-ios/pull/126))
- Room: Use bubbles in the timeline. ([#34](https://github.com/vector-im/element-x-ios/issues/34))
- Room: Add header view containing room avatar and encryption badge. ([#35](https://github.com/vector-im/element-x-ios/issues/35))
- Add the splash, login and server selection screens from Element iOS along with a UserSessionStore. ([#40](https://github.com/vector-im/element-x-ios/issues/40))
- DesignKit: Add DesignKit to the ElementX project, style the login screen with it and tint the whole app. ([#43](https://github.com/vector-im/element-x-ios/issues/43))
- Settings: Auto dismiss bug report screen and show a success indicator when bug report completed. ([#76](https://github.com/vector-im/element-x-ios/issues/76))
- Bug report: Add GH labels. ([#77](https://github.com/vector-im/element-x-ios/issues/77))
- Danger: Add a check for png files and warn to use SVG and PDF files. ([#87](https://github.com/vector-im/element-x-ios/issues/87))
- Add localizations to UI tests target and add some checks. ([#101](https://github.com/vector-im/element-x-ios/issues/101))

🐛 Bugfixes

- ElementInfoPlist: Use custom template for Info.plist. ([#71](https://github.com/vector-im/element-x-ios/issues/71))
- Add a sync limit of 20 timeline items and prefill rooms with this number of events when calculating the last message. ([#93](https://github.com/vector-im/element-x-ios/issues/93))

🧱 Build

- Add swiftformat to the project and run it for the first time. ([#129](https://github.com/vector-im/element-x-ios/pull/129))
- Use v0.0.1 of the DesignTokens package. ([#78](https://github.com/vector-im/element-x-ios/pull/78))
- Update to v0.0.2 of the DesignTokens package. ([#90](https://github.com/vector-im/element-x-ios/pull/90))
- Fix Danger's changelog detection. ([#74](https://github.com/vector-im/element-x-ios/issues/74))

🚧 In development 🚧

- Add a proof of concept implementation for login with OIDC. ([#42](https://github.com/vector-im/element-x-ios/issues/42))

Others

- Add Screen as a suffix to all screens and tidy up the template. ([#125](https://github.com/vector-im/element-x-ios/pull/125))
- Fix project urls in Towncrier configuration. ([#96](https://github.com/vector-im/element-x-ios/issues/96))
