//
//  ChatSceneInteractor.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

protocol ChatSceneInteractorProtocol {
    func connect()
    func sendMessage(_ message: String)
}

final class ChatSceneInteractor: ChatSceneInteractorProtocol {
    
    private let sockets: SocketsServiceProtocol
    
    init(_ injector: ServicesInjectorProtocol) {
        self.sockets = injector.socketsService
    }
    
    func connect() {
        sockets.connect()
    }
    
    func sendMessage(_ message: String) {
        sockets.send(.init(message))
    }
    
}
