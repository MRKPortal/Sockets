//
//  ChatScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import SwiftUI

protocol ChatScenePresenterProtocol: ObservableObject {
    func connect()
    func send(_ message: String)
}

final class ChatScenePresenter: ChatScenePresenterProtocol {
    
    private let interactor: ChatSceneInteractorProtocol
    
    init(interactor: ChatSceneInteractorProtocol) {
        self.interactor = interactor
    }
    
    func connect() {
        interactor.connect()
    }
    
    func send(_ message: String) {
        interactor.sendMessage(message)
    }
}
