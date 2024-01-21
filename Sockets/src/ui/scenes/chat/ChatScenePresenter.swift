//
//  ChatScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Combine
import SwiftUI

protocol ChatScenePresenterProtocol: ObservableObject {
    
    var feedbackPublisher: FeedbackPublisher { get }
    var title: String { get }
    var userId: String { get }
    var state: ConnectionState { get }
    var message: String { get set }
    var messages: [MessageModel] { get }
    
    func send()
    func didTapBack()
    func didTapCopyPrivate()
}

final class ChatScenePresenter: ChatScenePresenterProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let interactor: ChatSceneInteractorProtocol
    private let router: ChatSceneRouterProtocol
    private let feedback: FeedbackSystemProtocol
    
    let userId: String
    let title: String
    
    @Published var messages: [MessageModel] = []
    @Published var message: String = ""
    @Published var state: ConnectionState = .disconnected

    var feedbackPublisher: FeedbackPublisher {
        feedback.feedbackPublisher
    }
    
    init(interactor: ChatSceneInteractorProtocol, router: ChatSceneRouterProtocol, feedback: FeedbackSystemProtocol) {
        self.interactor = interactor
        self.router = router
        self.feedback = feedback
        self.userId = interactor.session.id
        self.title = interactor.room.name
        bind()
    }
    
    //MARK: - ChatScenePresenterProtocol
    func send() {
        Task { @MainActor in
            do {
                try interactor.sendMessage(
                    message.trimmingCharacters(in: .whitespacesAndNewlines)
                )
                message = ""
            } catch {
                feedback.display(feedback: .toast(error.localizedDescription))
            }
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

private extension ChatScenePresenter {
    func bind() {
        interactor
            .messagesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.messages += [message]
            }
            .store(in: &cancellables)

        interactor.statePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.state, onWeak: self)
            .store(in: &cancellables)
    }
}
