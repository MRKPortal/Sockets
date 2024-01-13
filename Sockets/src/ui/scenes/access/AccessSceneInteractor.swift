//
//  AccessSceneInteractor.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import Foundation

protocol AccessSceneInteractorProtocol {
    func configureSession(username: String, url: String) throws
}

final class AccessSceneInteractor: AccessSceneInteractorProtocol {
    
    private let storage: StorageServiceProtocol
    
    init(injector: ServicesInjectorProtocol) {
        self.storage = injector.storage
    }
    
    func configureSession(username: String, url: String) throws {
        let session = SessionModel(
            username: username.trimmingCharacters(in: .whitespacesAndNewlines),
            url: url.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        try storage.setSession(session)
        print(try? storage.getSession())
    }
}
