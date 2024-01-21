//
//  FeedbackService.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Combine
import Foundation

enum CustomAlert {
    case createRoom(DoubleStringCallback)
    case logOut(VoidCallback)
}

enum FeedbackType {
    case toast(String)
    case alert(CustomAlert)
}

protocol FeedbackSystemProtocol {
    var feedbackPublisher: FeedbackPublisher { get }

    func display(feedback: FeedbackType)
}

final class FeedbackSystem: FeedbackSystemProtocol {

    var feedbackPublisher: FeedbackPublisher {
        subject.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private let subject = FeedbackSubject()

    func display(feedback: FeedbackType) {
        subject.send(feedback)
    }
}
