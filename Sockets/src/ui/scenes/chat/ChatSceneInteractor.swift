//
//  ChatSceneInteractor.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

protocol ChatSceneInteractorProtocol {
    var session: SessionModel { get }
    var room: RoomModel { get }
    
    func connect(_ observer: @escaping MessagesCallback) throws
    func sendMessage(_ message: String) throws
}

final class ChatSceneInteractor: ChatSceneInteractorProtocol {
    
    private let sockets: SocketsServiceProtocol
    private let encryption: EncryptionServiceProtocol
    private let storage: StorageServiceProtocol
    
    private var observer: MessagesCallback?
    private var messages: [MessageModel] = []
    
    let session: SessionModel
    let room: RoomModel
    
    init(_ injector: ServicesInjectorProtocol, room: RoomModel) {
        self.sockets = injector.sockets
        self.encryption = injector.encryption
        self.storage = injector.storage
        self.session = (try? injector.storage.getSession()) ?? .init(username: "", url: "")
        self.room = room
    }
    
    func sendMessage(_ message: String) throws {
        let model: MessageModel = .init(sender: session.id, alias: session.username, message: message)
        let modelData = try JSONEncoder().encode(model)
        let encryptedModelData = try encryption.encrypt(data: modelData, key: room.key)
        sockets.send(encryptedModelData)
    }
    
    func connect(_ observer: @escaping MessagesCallback) throws {
        self.observer = observer
        print(try storage.getSession().url)
        sockets.connect(url: try storage.getSession().url) { [weak self] in
            self?.decrypt($0)
        }
    }
    
    func disconnect() {
        sockets.disconnect()
    }
}

private extension ChatSceneInteractor {
    func decrypt(_ data: Data) {
        guard let decrypted = try? encryption.decrypt(encrypted: data, key: room.key),
              let parsed = try? JSONDecoder().decode(MessageModel.self, from: decrypted) else {
            return
        }
        messages.append(parsed)
        observer?(messages)
    }
}
