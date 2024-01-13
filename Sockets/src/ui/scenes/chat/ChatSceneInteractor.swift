//
//  ChatSceneInteractor.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

protocol ChatSceneInteractorProtocol {
    func connect(_ observer: @escaping MessagesCallback) throws
    func sendMessage(_ message: String) throws
}

final class ChatSceneInteractor: ChatSceneInteractorProtocol {
    
    private let sockets: SocketsServiceProtocol
    private let encryption: EncryptionServiceProtocol
    private var observer: MessagesCallback?
    private var messages: [MessageModel] = []
    
    init(_ injector: ServicesInjectorProtocol) {
        self.sockets = injector.socketsService
        self.encryption = injector.encryptionService
    }

    func connect(_ observer: @escaping MessagesCallback) throws {
        try self.encryption.configureKey("<roomName>")
        self.observer = observer
        sockets.connect { [weak self] in
            self?.decrypt($0)
        }
    }
    
    func sendMessage(_ message: String) throws {
        let model: MessageModel = .init(message)
        let modelData = try JSONEncoder().encode(model)
        let encryptedModelData = try encryption.encrypt(data: modelData)
        sockets.send(encryptedModelData)
    }
}

private extension ChatSceneInteractor {
    func decrypt(_ data: Data) {
        guard let decrypted = try? encryption.decrypt(encrypted: data),
              let parsed = try? JSONDecoder().decode(MessageModel.self, from: decrypted) else {
            return
        }
        messages.append(parsed)
        observer?(messages)
    }
}
