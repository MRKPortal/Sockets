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
    func addRoom(name: String, key: String) throws
}

final class RoomsSceneInteractor: RoomsSceneInteractorProtocol {
    
    private let storage: StorageServiceProtocol
    
    init(_ injector: ServicesInjectorProtocol) {
        self.storage = injector.storage
    }
    
    //MARK: RoomsSceneInteractorProtocol
    
    func getSession() throws -> SessionModel {
        try storage.getSession()
    }
    
    func getRooms() throws -> [RoomModel] {
        try storage.getRooms()
    }
    
    func addRoom(name: String, key: String) throws {
        var rooms = (try? storage.getRooms()) ?? []
        rooms.append(
            RoomModel(name: name, key: key)
        )
        try storage.setRooms(rooms)
    }
    
}
