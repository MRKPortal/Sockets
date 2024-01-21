//
//  Publishers+Aliases.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Combine
import Foundation

typealias ConnectionPublisher = AnyPublisher<ConnectionState, Never>
typealias ConnectionSubject = CurrentValueSubject<ConnectionState, Never>

typealias StringPublisher = AnyPublisher<String, Never>
typealias StringSubject = PassthroughSubject<String, Never>

typealias DataPublisher = AnyPublisher<Data, Never>
typealias DataSubject = PassthroughSubject<Data, Never>

typealias MessagePublisher = AnyPublisher<MessageModel, Never>
typealias FeedbackPublisher = AnyPublisher<FeedbackType, Never>
typealias FeedbackSubject = PassthroughSubject<FeedbackType, Never>
