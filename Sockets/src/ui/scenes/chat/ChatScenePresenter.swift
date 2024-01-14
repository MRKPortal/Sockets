//
//  ChatScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import SwiftUI

protocol ChatScenePresenterProtocol: ObservableObject {
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

    let userId: String
    let title: String = "Super cool name for a group!"

    @Published var messages: [MessageModel] = []
    
    init(interactor: ChatSceneInteractorProtocol) {
        self.interactor = interactor
        self.userId = interactor.session.id
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
        print("copied decryption key")
    }
}
