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
}

final class StorageService: StorageServiceProtocol {
    
    private lazy var keychain = KeychainSwift()
    
    private enum Key: String {
        case session
    }
    
    func setSession(_ session: SessionModel) throws {
        let data = try JSONEncoder().encode(session)
        keychain.set(data, forKey: Key.session.rawValue)
    }
    
    func getSession() throws -> SessionModel {
        guard let data = keychain.getData(Key.session.rawValue) else {
            fatalError()
        }
        return try JSONDecoder().decode(SessionModel.self, from: data)
    }
}
