//
//  FeedbackService.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Combine

protocol FeedbackSystemProtocol {
    var messagePublisher: StringPublisher { get }

    func displayToast(message: String)
}

final class FeedbackSystem: FeedbackSystemProtocol {
    
    var messagePublisher: StringPublisher {
        subject.eraseToAnyPublisher()
    }
    
    private let subject = StringSubject()
    
    func displayToast(message: String) {
        subject.send(message)
    }
}
