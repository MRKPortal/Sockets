//
//  Publishers+Aliases.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Combine

typealias StringPublisher = AnyPublisher<String, Never>
typealias EventPublisher = AnyPublisher<SocketEvent, Never>
typealias MessagePublisher = AnyPublisher<MessageModel, Never>
typealias EventSubject = PassthroughSubject<SocketEvent, Never>
typealias StringSubject = PassthroughSubject<String, Never>
typealias FeedbackPublisher = AnyPublisher<FeedbackType, Never>
typealias FeedbackSubject = PassthroughSubject<FeedbackType, Never>
