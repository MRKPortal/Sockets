//
//  ChatScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import SwiftUI

protocol ChatScenePresenterProtocol: ObservableObject {
    
    var feedbackPublisher: FeedbackPublisher { get }
    
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
    private let router: ChatSceneRouterProtocol
    private let feedback: FeedbackSystemProtocol
    
    let userId: String
    let title: String
    
    @Published var messages: [MessageModel] = []
    
    var feedbackPublisher: FeedbackPublisher {
        feedback.feedbackPublisher
    }
    
    init(interactor: ChatSceneInteractorProtocol, router: ChatSceneRouterProtocol, feedback: FeedbackSystemProtocol) {
        self.interactor = interactor
        self.router = router
        self.feedback = feedback
        self.userId = interactor.session.id
        self.title = interactor.room.name
    }
    
    //MARK: - ChatScenePresenterProtocol
    
    func connect() {
        try? interactor.connect { messages in
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
        router.pop()
    }
    
    func didTapCopyPrivate() {
        UIPasteboard.general.string = interactor.room.password
        feedback.display(
            feedback: .toast(Ls.chatFeedbackKeyCopied)
        )
    }
}
