//
//  ChatScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import SwiftUI

protocol ChatScenePresenterProtocol: ObservableObject {
    
    var feedbackPublisher: StringPublisher { get }
    
    var title: String { get }
    var userId: String { get }
    var messages: [MessageModel] { get }

    func connect()
    func send(_ message: String)
    func didTapBack()
    func didTapCopyPrivate()
}

final class ChatScenePresenter: ChatScenePresenterProtocol {

    private let interactor: ChatSceneInteractorProtocol
    private let feedback: FeedbackSystemProtocol

    let userId: String
    let title: String

    @Published var messages: [MessageModel] = []
    
    var feedbackPublisher: StringPublisher {
        feedback.messagePublisher
    }
    
    init(interactor: ChatSceneInteractorProtocol, feedback: FeedbackSystemProtocol) {
        self.interactor = interactor
        self.feedback = feedback
        self.userId = interactor.session.id
        self.title = interactor.room.name
    }
    
    //MARK: - ChatScenePresenterProtocol
    
    func connect() {
        try! interactor.connect { messages in
            DispatchQueue.main.async {
                self.messages = messages
            }
        }
    }
    
    func send(_ message: String) {
        Task {
            try! interactor.sendMessage(
                message.trimmingCharacters(in: .whitespacesAndNewlines)
            )
        }
    }
    
    func didTapBack() {
        print("return to home")
    }
    
    func didTapCopyPrivate() {
        UIPasteboard.general.string = interactor.room.key
        feedback.displayToast(message: Ls.chatFeedbackKeyCopied)
    }
}
