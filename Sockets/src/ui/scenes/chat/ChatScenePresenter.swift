//
//  ChatScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import SwiftUI

protocol ChatScenePresenterProtocol: ObservableObject {
    var messages: [MessageModel] { get }
    func connect()
    func send(_ message: String)
}

final class ChatScenePresenter: ChatScenePresenterProtocol {
    
    private let interactor: ChatSceneInteractorProtocol
    
    @Published var messages: [MessageModel] = []
    
    init(interactor: ChatSceneInteractorProtocol) {
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
