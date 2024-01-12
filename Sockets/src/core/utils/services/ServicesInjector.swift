//
//  ServicesInjector.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

protocol ServicesInjectorProtocol {
    var encryptionService: EncryptionServiceProtocol { get }
    var socketsService: SocketsServiceProtocol { get }
}

final class ServicesInjector: ServicesInjectorProtocol {
    var encryptionService: EncryptionServiceProtocol = EncryptionService()
    var socketsService: SocketsServiceProtocol = SocketsService("wss://socketsbay.com/wss/v2/1/demo/")
}
