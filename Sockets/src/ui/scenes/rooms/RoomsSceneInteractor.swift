//
//  RoomsSceneInteractor.swift
//  Sockets
//
//  Created by Marc Flores on 18/1/24.
//

import Foundation

protocol RoomsSceneInteractorProtocol {
    func getSession() throws -> SessionModel
    func getRooms() throws -> [RoomModel]
    func addRoom(name: String, password: String) throws
}

final class RoomsSceneInteractor: RoomsSceneInteractorProtocol {
    
    private let storage: StorageServiceProtocol
    private let encryption: EncryptionServiceProtocol

    init(_ injector: ServicesInjectorProtocol) {
        self.storage = injector.storage
        self.encryption = injector.encryption
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
    
}
