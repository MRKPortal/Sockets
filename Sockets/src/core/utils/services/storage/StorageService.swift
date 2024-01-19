//
//  StorageService.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import KeychainSwift
import Foundation

protocol StorageServiceProtocol {
    func setSession(_ session: SessionModel) throws
    func getSession() throws -> SessionModel
    
    func setRooms(_ rooms: [RoomModel]) throws
    func getRooms() throws -> [RoomModel]
    
    func clear()
}

final class StorageService: StorageServiceProtocol {
    
    private lazy var keychain = KeychainSwift()
    
    private enum Key: String {
        case session, rooms
    }
    
    func setSession(_ session: SessionModel) throws {
        let data = try JSONEncoder().encode(session)
        keychain.set(data, forKey: Key.session.rawValue)
    }
    
    func getSession() throws -> SessionModel {
        guard let data = keychain.getData(Key.session.rawValue) else {
            throw StorageError.notFound
        }
        return try JSONDecoder().decode(SessionModel.self, from: data)
    }
    
    func setRooms(_ rooms: [RoomModel]) throws {
        let data = try JSONEncoder().encode(rooms)
        keychain.set(data, forKey: Key.rooms.rawValue)
    }
    
    func getRooms() throws -> [RoomModel] {
        guard let data = keychain.getData(Key.rooms.rawValue) else {
            throw StorageError.notFound
        }
        return try JSONDecoder().decode([RoomModel].self, from: data)
    }
    
    func clear() {
        keychain.clear()
    }
}
