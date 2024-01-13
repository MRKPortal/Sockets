//
//  ChatSceneInteractor.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

protocol ChatSceneInteractorProtocol {
    var userId: String { get }
    func connect(_ observer: @escaping MessagesCallback) throws
    func sendMessage(_ message: String) throws
}

final class ChatSceneInteractor: ChatSceneInteractorProtocol {
    
    private let sockets: SocketsServiceProtocol
    private let encryption: EncryptionServiceProtocol
    private let storage: StorageServiceProtocol
    
    private var observer: MessagesCallback?
    private var messages: [MessageModel] = []
    
    var userId: String {
        (try? storage.getSession().id) ?? ""
    }
    
    init(_ injector: ServicesInjectorProtocol) {
        self.sockets = injector.sockets
        self.encryption = injector.encryption
        self.storage = injector.storage
    }

    func connect(_ observer: @escaping MessagesCallback) throws {
        try self.encryption.configureKey("<roomName>")
        self.observer = observer
        sockets.connect(url: try storage.getSession().url) { [weak self] in
            self?.decrypt($0)
        }
    }
    
    func sendMessage(_ message: String) throws {
        let session = try storage.getSession()
        let model: MessageModel = .init(sender: session.id, alias: session.username, message: message)
        let modelData = try JSONEncoder().encode(model)
        let encryptedModelData = try encryption.encrypt(data: modelData)
        sockets.send(encryptedModelData)
    }
    
    func disconnect() {
        sockets.disconnect()
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
