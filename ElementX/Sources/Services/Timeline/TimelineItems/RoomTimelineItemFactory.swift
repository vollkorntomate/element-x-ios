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

import MatrixRustSDK
import UIKit
import UniformTypeIdentifiers

struct RoomTimelineItemFactory: RoomTimelineItemFactoryProtocol {
    private let mediaProvider: MediaProviderProtocol
    private let attributedStringBuilder: AttributedStringBuilderProtocol
    private let stateEventStringBuilder: RoomStateEventStringBuilder
    private let appSettings: AppSettings
    
    /// The Matrix ID of the current user.
    private let userID: String
    
    init(userID: String,
         mediaProvider: MediaProviderProtocol,
         attributedStringBuilder: AttributedStringBuilderProtocol,
         stateEventStringBuilder: RoomStateEventStringBuilder,
         appSettings: AppSettings) {
        self.userID = userID
        self.mediaProvider = mediaProvider
        self.attributedStringBuilder = attributedStringBuilder
        self.stateEventStringBuilder = stateEventStringBuilder
        self.appSettings = appSettings
    }
    
    func buildTimelineItem(for eventItemProxy: EventTimelineItemProxy) -> RoomTimelineItemProtocol? {
        let isOutgoing = eventItemProxy.isOwn
        
        switch eventItemProxy.content.kind() {
        case .unableToDecrypt(let encryptedMessage):
            return buildEncryptedTimelineItem(eventItemProxy, encryptedMessage, isOutgoing)
        case .redactedMessage:
            return buildRedactedTimelineItem(eventItemProxy, isOutgoing)
        case .sticker(let body, let imageInfo, let urlString):
            guard let url = URL(string: urlString) else {
                MXLog.error("Invalid sticker url string: \(urlString)")
                return buildUnsupportedTimelineItem(eventItemProxy, "m.sticker", "Invalid Sticker URL", isOutgoing)
            }
            
            return buildStickerTimelineItem(eventItemProxy, body, imageInfo, url, isOutgoing)
        case .failedToParseMessageLike(let eventType, let error):
            return buildUnsupportedTimelineItem(eventItemProxy, eventType, error, isOutgoing)
        case .failedToParseState(let eventType, _, let error):
            return buildUnsupportedTimelineItem(eventItemProxy, eventType, error, isOutgoing)
        case .message:
            return buildMessageTimelineItem(eventItemProxy, isOutgoing)
        case .state(let stateKey, let content):
            return buildStateTimelineItem(for: eventItemProxy, state: content, stateKey: stateKey, isOutgoing: isOutgoing)
        case .roomMembership(userId: let userID, change: let change):
            return buildStateMembershipChangeTimelineItem(for: eventItemProxy, member: userID, membershipChange: change, isOutgoing: isOutgoing)
        case .profileChange(let displayName, let prevDisplayName, let avatarUrl, let prevAvatarUrl):
            return buildStateProfileChangeTimelineItem(for: eventItemProxy,
                                                       displayName: displayName,
                                                       previousDisplayName: prevDisplayName,
                                                       avatarURLString: avatarUrl,
                                                       previousAvatarURLString: prevAvatarUrl,
                                                       isOutgoing: isOutgoing)
        case .poll(question: let question, kind: let kind, maxSelections: let maxSelections, answers: let answers, votes: let votes, endTime: let endTime):
            return buildPollTimelineItem(question, kind, maxSelections, answers, votes, endTime, eventItemProxy, isOutgoing)
        }
    }
    
    // MARK: - Message Events

    private func buildMessageTimelineItem(_ eventItemProxy: EventTimelineItemProxy, _ isOutgoing: Bool) -> RoomTimelineItemProtocol? {
        guard let messageTimelineItem = eventItemProxy.content.asMessage() else {
            fatalError("Invalid message timeline item: \(eventItemProxy)")
        }

        let isThreaded = messageTimelineItem.isThreaded()
        switch messageTimelineItem.msgtype() {
        case .text(content: let content):
            return buildTextTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
        case .image(content: let content):
            return buildImageTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
        case .video(let content):
            return buildVideoTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
        case .file(let content):
            return buildFileTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
        case .notice(content: let content):
            return buildNoticeTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
        case .emote(content: let content):
            return buildEmoteTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
        case .audio(let content):
            if appSettings.voiceMessageEnabled, content.voice != nil {
                return buildVoiceTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
            } else {
                return buildAudioTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
            }
        case .location(let content):
            return buildLocationTimelineItem(for: eventItemProxy, messageTimelineItem, content, isOutgoing, isThreaded)
        case .other:
            return nil
        }
    }
    
    private func buildUnsupportedTimelineItem(_ eventItemProxy: EventTimelineItemProxy,
                                              _ eventType: String,
                                              _ error: String,
                                              _ isOutgoing: Bool) -> RoomTimelineItemProtocol {
        UnsupportedRoomTimelineItem(id: eventItemProxy.id,
                                    body: L10n.commonUnsupportedEvent,
                                    eventType: eventType,
                                    error: error,
                                    timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                                    isOutgoing: isOutgoing,
                                    isEditable: eventItemProxy.isEditable,
                                    canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                                    sender: eventItemProxy.sender,
                                    properties: RoomTimelineItemProperties())
    }
    
    private func buildStickerTimelineItem(_ eventItemProxy: EventTimelineItemProxy,
                                          _ body: String,
                                          _ imageInfo: ImageInfo,
                                          _ imageURL: URL,
                                          _ isOutgoing: Bool) -> RoomTimelineItemProtocol {
        var aspectRatio: CGFloat?
        let width = imageInfo.width.map(CGFloat.init)
        let height = imageInfo.height.map(CGFloat.init)
        if let width, let height {
            aspectRatio = width / height
        }
        
        return StickerRoomTimelineItem(id: eventItemProxy.id,
                                       body: body,
                                       timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                                       isOutgoing: isOutgoing,
                                       isEditable: eventItemProxy.isEditable,
                                       canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                                       sender: eventItemProxy.sender,
                                       imageURL: imageURL,
                                       width: width,
                                       height: height,
                                       aspectRatio: aspectRatio,
                                       blurhash: imageInfo.blurhash,
                                       properties: RoomTimelineItemProperties(reactions: aggregateReactions(eventItemProxy.reactions),
                                                                              deliveryStatus: eventItemProxy.deliveryStatus,
                                                                              orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildEncryptedTimelineItem(_ eventItemProxy: EventTimelineItemProxy,
                                            _ encryptedMessage: EncryptedMessage,
                                            _ isOutgoing: Bool) -> RoomTimelineItemProtocol {
        var encryptionType = EncryptedRoomTimelineItem.EncryptionType.unknown
        switch encryptedMessage {
        case .megolmV1AesSha2(let sessionId):
            encryptionType = .megolmV1AesSha2(sessionId: sessionId)
        case .olmV1Curve25519AesSha2(let senderKey):
            encryptionType = .olmV1Curve25519AesSha2(senderKey: senderKey)
        default:
            break
        }
        
        return EncryptedRoomTimelineItem(id: eventItemProxy.id,
                                         body: L10n.commonUnableToDecrypt,
                                         encryptionType: encryptionType,
                                         timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                                         isOutgoing: isOutgoing,
                                         isEditable: eventItemProxy.isEditable,
                                         canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                                         sender: eventItemProxy.sender,
                                         properties: RoomTimelineItemProperties())
    }
    
    private func buildRedactedTimelineItem(_ eventItemProxy: EventTimelineItemProxy,
                                           _ isOutgoing: Bool) -> RoomTimelineItemProtocol {
        RedactedRoomTimelineItem(id: eventItemProxy.id,
                                 body: L10n.commonMessageRemoved,
                                 timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                                 isOutgoing: isOutgoing,
                                 isEditable: eventItemProxy.isEditable,
                                 canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                                 sender: eventItemProxy.sender,
                                 properties: RoomTimelineItemProperties())
    }
    
    private func buildTextTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                       _ messageTimelineItem: Message,
                                       _ messageContent: TextMessageContent,
                                       _ isOutgoing: Bool,
                                       _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        TextRoomTimelineItem(id: eventItemProxy.id,
                             timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                             isOutgoing: isOutgoing,
                             isEditable: eventItemProxy.isEditable,
                             canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                             isThreaded: isThreaded,
                             sender: eventItemProxy.sender,
                             content: buildTextTimelineItemContent(messageContent),
                             replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                             properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                    reactions: aggregateReactions(eventItemProxy.reactions),
                                                                    deliveryStatus: eventItemProxy.deliveryStatus,
                                                                    orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildImageTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                        _ messageTimelineItem: Message,
                                        _ messageContent: ImageMessageContent,
                                        _ isOutgoing: Bool,
                                        _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        ImageRoomTimelineItem(id: eventItemProxy.id,
                              timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                              isOutgoing: isOutgoing,
                              isEditable: eventItemProxy.isEditable,
                              canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                              isThreaded: isThreaded,
                              sender: eventItemProxy.sender,
                              content: buildImageTimelineItemContent(messageContent),
                              replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                              properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                     reactions: aggregateReactions(eventItemProxy.reactions),
                                                                     deliveryStatus: eventItemProxy.deliveryStatus,
                                                                     orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildVideoTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                        _ messageTimelineItem: Message,
                                        _ messageContent: VideoMessageContent,
                                        _ isOutgoing: Bool,
                                        _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        VideoRoomTimelineItem(id: eventItemProxy.id,
                              timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                              isOutgoing: isOutgoing,
                              isEditable: eventItemProxy.isEditable,
                              canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                              isThreaded: isThreaded,
                              sender: eventItemProxy.sender,
                              content: buildVideoTimelineItemContent(messageContent),
                              replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                              properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                     reactions: aggregateReactions(eventItemProxy.reactions),
                                                                     deliveryStatus: eventItemProxy.deliveryStatus,
                                                                     orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildAudioTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                        _ messageTimelineItem: Message,
                                        _ messageContent: AudioMessageContent,
                                        _ isOutgoing: Bool,
                                        _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        AudioRoomTimelineItem(id: eventItemProxy.id,
                              timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                              isOutgoing: isOutgoing,
                              isEditable: eventItemProxy.isEditable,
                              canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                              isThreaded: isThreaded,
                              sender: eventItemProxy.sender,
                              content: buildAudioTimelineItemContent(messageContent),
                              replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                              properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                     reactions: aggregateReactions(eventItemProxy.reactions),
                                                                     deliveryStatus: eventItemProxy.deliveryStatus,
                                                                     orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildVoiceTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                        _ messageTimelineItem: Message,
                                        _ messageContent: AudioMessageContent,
                                        _ isOutgoing: Bool,
                                        _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        VoiceMessageRoomTimelineItem(id: eventItemProxy.id,
                                     timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                                     isOutgoing: isOutgoing,
                                     isEditable: eventItemProxy.isEditable,
                                     canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                                     isThreaded: isThreaded,
                                     sender: eventItemProxy.sender,
                                     content: buildAudioTimelineItemContent(messageContent),
                                     replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                                     properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                            reactions: aggregateReactions(eventItemProxy.reactions),
                                                                            deliveryStatus: eventItemProxy.deliveryStatus,
                                                                            orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildFileTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                       _ messageTimelineItem: Message,
                                       _ messageContent: FileMessageContent,
                                       _ isOutgoing: Bool,
                                       _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        FileRoomTimelineItem(id: eventItemProxy.id,
                             timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                             isOutgoing: isOutgoing,
                             isEditable: eventItemProxy.isEditable,
                             canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                             isThreaded: isThreaded,
                             sender: eventItemProxy.sender,
                             content: buildFileTimelineItemContent(messageContent),
                             replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                             properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                    reactions: aggregateReactions(eventItemProxy.reactions),
                                                                    deliveryStatus: eventItemProxy.deliveryStatus,
                                                                    orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildNoticeTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                         _ messageTimelineItem: Message,
                                         _ messageContent: NoticeMessageContent,
                                         _ isOutgoing: Bool,
                                         _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        NoticeRoomTimelineItem(id: eventItemProxy.id,
                               timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                               isOutgoing: isOutgoing,
                               isEditable: eventItemProxy.isEditable,
                               canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                               isThreaded: isThreaded,
                               sender: eventItemProxy.sender,
                               content: buildNoticeTimelineItemContent(messageContent),
                               replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                               properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                      reactions: aggregateReactions(eventItemProxy.reactions),
                                                                      deliveryStatus: eventItemProxy.deliveryStatus,
                                                                      orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func buildEmoteTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                        _ messageTimelineItem: Message,
                                        _ messageContent: EmoteMessageContent,
                                        _ isOutgoing: Bool,
                                        _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        EmoteRoomTimelineItem(id: eventItemProxy.id,
                              timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                              isOutgoing: isOutgoing,
                              isEditable: eventItemProxy.isEditable,
                              canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                              isThreaded: isThreaded,
                              sender: eventItemProxy.sender,
                              content: buildEmoteTimelineItemContent(senderDisplayName: eventItemProxy.sender.displayName, senderID: eventItemProxy.sender.id, messageContent: messageContent),
                              replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                              properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                     reactions: aggregateReactions(eventItemProxy.reactions),
                                                                     deliveryStatus: eventItemProxy.deliveryStatus,
                                                                     orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }

    private func buildLocationTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                           _ messageTimelineItem: Message,
                                           _ messageContent: LocationContent,
                                           _ isOutgoing: Bool,
                                           _ isThreaded: Bool) -> RoomTimelineItemProtocol {
        LocationRoomTimelineItem(id: eventItemProxy.id,
                                 timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                                 isOutgoing: isOutgoing,
                                 isEditable: eventItemProxy.isEditable,
                                 canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                                 isThreaded: isThreaded,
                                 sender: eventItemProxy.sender,
                                 content: buildLocationTimelineItemContent(messageContent),
                                 replyDetails: buildReplyToDetailsFrom(details: messageTimelineItem.inReplyTo()),
                                 properties: RoomTimelineItemProperties(isEdited: messageTimelineItem.isEdited(),
                                                                        reactions: aggregateReactions(eventItemProxy.reactions),
                                                                        deliveryStatus: eventItemProxy.deliveryStatus,
                                                                        orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }

    // swiftlint:disable:next function_parameter_count
    private func buildPollTimelineItem(_ question: String,
                                       _ pollKind: PollKind,
                                       _ maxSelections: UInt64,
                                       _ answers: [PollAnswer],
                                       _ votes: [String: [String]],
                                       _ endTime: UInt64?,
                                       _ eventItemProxy: EventTimelineItemProxy,
                                       _ isOutgoing: Bool) -> RoomTimelineItemProtocol {
        let allVotes = votes.reduce(0) { count, pair in
            count + pair.value.count
        }

        let maxOptionVotes = votes.map(\.value.count).max()

        let options = answers.map { answer in
            let optionVotesCount = votes[answer.id]?.count
            
            return Poll.Option(id: answer.id,
                               text: answer.text,
                               votes: optionVotesCount ?? 0,
                               allVotes: allVotes,
                               isSelected: votes[answer.id]?.contains(userID) ?? false,
                               isWinning: optionVotesCount.map { $0 == maxOptionVotes } ?? false)
        }

        let poll = Poll(question: question,
                        kind: .init(pollKind: pollKind),
                        maxSelections: Int(maxSelections),
                        options: options,
                        votes: votes,
                        endDate: endTime.map { Date(timeIntervalSince1970: TimeInterval($0 / 1000)) },
                        createdByAccountOwner: eventItemProxy.sender.id == userID)

        return PollRoomTimelineItem(id: eventItemProxy.id,
                                    poll: poll,
                                    body: poll.question,
                                    timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                                    isOutgoing: isOutgoing,
                                    isEditable: eventItemProxy.isEditable,
                                    canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                                    sender: eventItemProxy.sender,
                                    properties: RoomTimelineItemProperties(isEdited: false,
                                                                           reactions: aggregateReactions(eventItemProxy.reactions),
                                                                           deliveryStatus: eventItemProxy.deliveryStatus,
                                                                           orderedReadReceipts: orderReadReceipts(eventItemProxy.readReceipts)))
    }
    
    private func aggregateReactions(_ reactions: [Reaction]) -> [AggregatedReaction] {
        reactions.map { reaction in
            let senders = reaction.senders
                .map { senderData in
                    ReactionSender(senderID: senderData.senderId, timestamp: Date(timeIntervalSince1970: TimeInterval(senderData.timestamp / 1000)))
                }
                .sorted { a, b in
                    // Sort reactions within an aggregation by timestamp descending.
                    // This puts the most recent at the top, useful in cases like the
                    // reaction summary view.
                    a.timestamp > b.timestamp
                }
            return AggregatedReaction(accountOwnerID: userID, key: reaction.key, senders: senders)
        }
        .sorted { a, b in
            // Sort aggregated reactions by count and then timestamp ascending, using
            // the most recent reaction in the aggregation(hence index 0).
            // This appends new aggregations on the end of the reaction layout
            // and the deterministic sort avoids reactions jumping around if the reactions timeline
            // view reloads.
            if a.count == b.count {
                return a.senders[0].timestamp < b.senders[0].timestamp
            }
            return a.count > b.count
        }
    }

    private func orderReadReceipts(_ receipts: [String: Receipt]) -> [ReadReceipt] {
        receipts
            .sorted { firstElement, secondElement in
                // If there is no timestamp we order them as last
                let firstTimestamp = firstElement.value.dateTimestamp ?? Date(timeIntervalSince1970: 0)
                let secondTimestamp = secondElement.value.dateTimestamp ?? Date(timeIntervalSince1970: 0)
                return firstTimestamp > secondTimestamp
            }
            .map { key, receipt in
                ReadReceipt(userID: key, formattedTimestamp: receipt.dateTimestamp?.formatted(date: .omitted, time: .shortened))
            }
    }
    
    // MARK: - Message events content
    
    private func buildTextTimelineItemContent(_ messageContent: TextMessageContent) -> TextRoomTimelineItemContent {
        let htmlBody = messageContent.formatted?.format == .html ? messageContent.formatted?.body : nil
        let formattedBody = (htmlBody != nil ? attributedStringBuilder.fromHTML(htmlBody) : attributedStringBuilder.fromPlain(messageContent.body))
        
        return .init(body: messageContent.body, formattedBody: formattedBody, formattedBodyHTMLString: htmlBody)
    }
    
    private func buildAudioTimelineItemContent(_ messageContent: AudioMessageContent) -> AudioRoomTimelineItemContent {
        var waveform: Waveform?
        if let audioWaveform = messageContent.audio?.waveform {
            waveform = Waveform(data: audioWaveform)
        }

        return AudioRoomTimelineItemContent(body: messageContent.body,
                                            duration: messageContent.audio?.duration ?? 0,
                                            waveform: waveform,
                                            source: MediaSourceProxy(source: messageContent.source, mimeType: messageContent.info?.mimetype),
                                            contentType: UTType(mimeType: messageContent.info?.mimetype, fallbackFilename: messageContent.body))
    }

    private func buildImageTimelineItemContent(_ messageContent: ImageMessageContent) -> ImageRoomTimelineItemContent {
        let thumbnailSource = messageContent.info?.thumbnailSource.map { MediaSourceProxy(source: $0, mimeType: messageContent.info?.thumbnailInfo?.mimetype) }
        let width = messageContent.info?.width.map(CGFloat.init)
        let height = messageContent.info?.height.map(CGFloat.init)
        
        var aspectRatio: CGFloat?
        if let width, let height {
            aspectRatio = width / height
        }
        
        return .init(body: messageContent.body,
                     source: MediaSourceProxy(source: messageContent.source, mimeType: messageContent.info?.mimetype),
                     thumbnailSource: thumbnailSource,
                     width: width,
                     height: height,
                     aspectRatio: aspectRatio,
                     blurhash: messageContent.info?.blurhash,
                     contentType: UTType(mimeType: messageContent.info?.mimetype, fallbackFilename: messageContent.body))
    }

    private func buildVideoTimelineItemContent(_ messageContent: VideoMessageContent) -> VideoRoomTimelineItemContent {
        let thumbnailSource = messageContent.info?.thumbnailSource.map { MediaSourceProxy(source: $0, mimeType: messageContent.info?.thumbnailInfo?.mimetype) }
        let width = messageContent.info?.width.map(CGFloat.init)
        let height = messageContent.info?.height.map(CGFloat.init)
        
        var aspectRatio: CGFloat?
        if let width, let height {
            aspectRatio = width / height
        }
        
        return .init(body: messageContent.body,
                     duration: messageContent.info?.duration ?? 0,
                     source: MediaSourceProxy(source: messageContent.source, mimeType: messageContent.info?.mimetype),
                     thumbnailSource: thumbnailSource,
                     width: width,
                     height: height,
                     aspectRatio: aspectRatio,
                     blurhash: messageContent.info?.blurhash,
                     contentType: UTType(mimeType: messageContent.info?.mimetype, fallbackFilename: messageContent.body))
    }

    private func buildLocationTimelineItemContent(_ locationContent: LocationContent) -> LocationRoomTimelineItemContent {
        LocationRoomTimelineItemContent(body: locationContent.body,
                                        geoURI: .init(string: locationContent.geoUri),
                                        description: locationContent.description,
                                        zoomLevel: locationContent.zoomLevel,
                                        asset: locationContent.asset.map { .init(assetType: $0) })
    }

    private func buildFileTimelineItemContent(_ messageContent: FileMessageContent) -> FileRoomTimelineItemContent {
        let thumbnailSource = messageContent.info?.thumbnailSource.map { MediaSourceProxy(source: $0, mimeType: messageContent.info?.thumbnailInfo?.mimetype) }
        
        return .init(body: messageContent.body,
                     source: MediaSourceProxy(source: messageContent.source, mimeType: messageContent.info?.mimetype),
                     thumbnailSource: thumbnailSource,
                     contentType: UTType(mimeType: messageContent.info?.mimetype, fallbackFilename: messageContent.body))
    }
    
    private func buildNoticeTimelineItemContent(_ messageContent: NoticeMessageContent) -> NoticeRoomTimelineItemContent {
        let htmlBody = messageContent.formatted?.format == .html ? messageContent.formatted?.body : nil
        let formattedBody = (htmlBody != nil ? attributedStringBuilder.fromHTML(htmlBody) : attributedStringBuilder.fromPlain(messageContent.body))
        
        return .init(body: messageContent.body, formattedBody: formattedBody)
    }
    
    private func buildEmoteTimelineItemContent(senderDisplayName: String?, senderID: String, messageContent: EmoteMessageContent) -> EmoteRoomTimelineItemContent {
        let name = senderDisplayName ?? senderID
        
        let htmlBody = messageContent.formatted?.format == .html ? messageContent.formatted?.body : nil

        var formattedBody: AttributedString?
        if let htmlBody {
            formattedBody = attributedStringBuilder.fromHTML(L10n.commonEmote(name, htmlBody))
        } else {
            formattedBody = attributedStringBuilder.fromPlain(L10n.commonEmote(name, messageContent.body))
        }
        
        return .init(body: messageContent.body, formattedBody: formattedBody, formattedBodyHTMLString: htmlBody)
    }
    
    // MARK: - State Events
    
    private func buildStateTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                        state: OtherState,
                                        stateKey: String,
                                        isOutgoing: Bool) -> RoomTimelineItemProtocol? {
        guard let text = stateEventStringBuilder.buildString(for: state, stateKey: stateKey, sender: eventItemProxy.sender, isOutgoing: isOutgoing) else { return nil }
        return buildStateTimelineItem(for: eventItemProxy, text: text, isOutgoing: isOutgoing)
    }
    
    private func buildStateMembershipChangeTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                                        member: String,
                                                        membershipChange: MembershipChange?,
                                                        isOutgoing: Bool) -> RoomTimelineItemProtocol? {
        guard let text = stateEventStringBuilder.buildString(for: membershipChange, member: member, sender: eventItemProxy.sender, isOutgoing: isOutgoing) else { return nil }
        return buildStateTimelineItem(for: eventItemProxy, text: text, isOutgoing: isOutgoing)
    }
    
    // swiftlint:disable:next function_parameter_count
    private func buildStateProfileChangeTimelineItem(for eventItemProxy: EventTimelineItemProxy,
                                                     displayName: String?,
                                                     previousDisplayName: String?,
                                                     avatarURLString: String?,
                                                     previousAvatarURLString: String?,
                                                     isOutgoing: Bool) -> RoomTimelineItemProtocol? {
        guard let text = stateEventStringBuilder.buildProfileChangeString(displayName: displayName,
                                                                          previousDisplayName: previousDisplayName,
                                                                          avatarURLString: avatarURLString,
                                                                          previousAvatarURLString: previousAvatarURLString,
                                                                          member: eventItemProxy.sender.id,
                                                                          memberIsYou: isOutgoing) else { return nil }
        return buildStateTimelineItem(for: eventItemProxy, text: text, isOutgoing: isOutgoing)
    }
    
    private func buildStateTimelineItem(for eventItemProxy: EventTimelineItemProxy, text: String, isOutgoing: Bool) -> RoomTimelineItemProtocol {
        StateRoomTimelineItem(id: eventItemProxy.id,
                              body: text,
                              timestamp: eventItemProxy.timestamp.formatted(date: .omitted, time: .shortened),
                              isOutgoing: isOutgoing,
                              isEditable: false,
                              canBeRepliedTo: eventItemProxy.canBeRepliedTo,
                              sender: eventItemProxy.sender)
    }
    
    // MARK: - Reply details
    
    private func buildReplyToDetailsFrom(details: InReplyToDetails?) -> TimelineItemReplyDetails? {
        guard let details else { return nil }
        
        switch details.event {
        case .unavailable:
            return .notLoaded(eventID: details.eventId)
        case .pending:
            return .loading(eventID: details.eventId)
        case let .ready(timelineItem, senderID, senderProfile):
            let sender: TimelineItemSender
            switch senderProfile {
            case let .ready(displayName, _, avatarUrl):
                sender = TimelineItemSender(id: senderID,
                                            displayName: displayName,
                                            avatarURL: avatarUrl.flatMap(URL.init(string:)))
            default:
                sender = TimelineItemSender(id: senderID,
                                            displayName: nil,
                                            avatarURL: nil)
            }
            
            let replyContent: EventBasedMessageTimelineItemContentType

            switch timelineItem.kind() {
            case .message:
                switch timelineItem.asMessage()?.msgtype() {
                case .audio(let content):
                    if appSettings.voiceMessageEnabled, content.voice != nil {
                        replyContent = .voice(buildAudioTimelineItemContent(content))
                    } else {
                        replyContent = .audio(buildAudioTimelineItemContent(content))
                    }
                case .emote(let content):
                    replyContent = .emote(buildEmoteTimelineItemContent(senderDisplayName: sender.displayName, senderID: sender.id, messageContent: content))
                case .file(let content):
                    replyContent = .file(buildFileTimelineItemContent(content))
                case .image(let content):
                    replyContent = .image(buildImageTimelineItemContent(content))
                case .notice(let content):
                    replyContent = .notice(buildNoticeTimelineItemContent(content))
                case .text(let content):
                    replyContent = .text(buildTextTimelineItemContent(content))
                case .video(let content):
                    replyContent = .video(buildVideoTimelineItemContent(content))
                case .location(let content):
                    replyContent = .location(buildLocationTimelineItemContent(content))
                case .other, .none:
                    replyContent = .text(.init(body: L10n.commonUnsupportedEvent))
                }
            case .poll(let question, _, _, _, _, _):
                replyContent = .text(.init(body: question))
            case .sticker(let body, _, _):
                replyContent = .text(.init(body: body))
            default:
                replyContent = .text(.init(body: L10n.commonUnsupportedEvent))
            }
            
            return .loaded(sender: sender, contentType: replyContent)
        case let .error(message):
            return .error(eventID: details.eventId, message: message)
        }
    }
}

private extension LocationRoomTimelineItemContent.AssetType {
    init(assetType: MatrixRustSDK.AssetType) {
        switch assetType {
        case .sender:
            self = .sender
        case .pin:
            self = .pin
        }
    }
}

extension Poll.Kind {
    init(pollKind: MatrixRustSDK.PollKind) {
        switch pollKind {
        case .disclosed:
            self = .disclosed
        case .undisclosed:
            self = .undisclosed
        }
    }
}
