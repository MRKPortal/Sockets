//
//  Publishers+Aliases.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Combine

typealias StringPublisher = AnyPublisher<String, Never>
typealias StringSubject = PassthroughSubject<String, Never>
typealias FeedbackPublisher = AnyPublisher<FeedbackType, Never>
typealias FeedbackSubject = PassthroughSubject<FeedbackType, Never>
