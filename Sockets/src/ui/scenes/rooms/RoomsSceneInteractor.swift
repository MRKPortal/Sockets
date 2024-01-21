//
//  RoomsSceneInteractor.swift
//  Sockets
//
//  Created by Marc Flores on 18/1/24.
//

import Foundation

protocol RoomsSceneInteractorProtocol {
    var connectionPublisher: ConnectionPublisher { get }
    
    func getSession() throws -> SessionModel
    func getRooms() throws -> [RoomModel]
    func addRoom(name: String, password: String) throws

    func connect() throws
    func logout()
}

final class RoomsSceneInteractor: RoomsSceneInteractorProtocol {
    
    private let storage: StorageServiceProtocol
    private let encryption: EncryptionServiceProtocol
    private let sockets: SocketsServiceProtocol

    init(_ injector: ServicesInjectorProtocol) {
        self.storage = injector.storage
        self.encryption = injector.encryption
        self.sockets = injector.sockets
    }
    
    var connectionPublisher: ConnectionPublisher {
        sockets.connectionPublisher
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    //MARK: RoomsSceneInteractorProtocol
    
    func getSession() throws -> SessionModel {
        try storage.getSession()
    }
    
    func getRooms() throws -> [RoomModel] {
        try storage.getRooms()
    }
    
    func addRoom(name: String, password: String) throws {
        var rooms = (try? storage.getRooms()) ?? []
        let key = try encryption.createKey(password)
        rooms.append(
            RoomModel(
                name: name,
                password: password,
                key: key
            )
        )
        try storage.setRooms(rooms)
    }

    func connect() throws {
        let url = try storage.getSession().url
        sockets.connect(url: url)
    }
    
    func logout() {
        sockets.disconnect()
        storage.clear()
    }
}
