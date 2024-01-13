//
//  ChatScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import SwiftUI

protocol ChatScenePresenterProtocol: ObservableObject {
    var userId: String { get }
    var messages: [MessageModel] { get }
    func connect()
    func send(_ message: String)
}

final class ChatScenePresenter: ChatScenePresenterProtocol {

    let userId: String
    
    private let interactor: ChatSceneInteractorProtocol

    @Published var messages: [MessageModel] = []
    
    init(interactor: ChatSceneInteractorProtocol) {
        self.userId = interactor.userId
        self.interactor = interactor
    }
    
    func connect() {
        try! interactor.connect { messages in
            DispatchQueue.main.async {
                self.messages = messages
            }
        }
    }
    
    func send(_ message: String) {
        Task {
            try! interactor.sendMessage(message)
        }
    }
}
