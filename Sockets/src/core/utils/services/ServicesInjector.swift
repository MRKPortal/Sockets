//
//  ServicesInjector.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

protocol ServicesInjectorProtocol {
    var storage: StorageServiceProtocol { get }
    var encryption: EncryptionServiceProtocol { get }
    var sockets: SocketsServiceProtocol { get }
}

final class ServicesInjector: ServicesInjectorProtocol {
    var encryption: EncryptionServiceProtocol = EncryptionService()
    var sockets: SocketsServiceProtocol = SocketsService()
    var storage: StorageServiceProtocol = StorageService()
}
