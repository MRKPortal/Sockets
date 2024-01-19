//
//  EncryptionService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import CryptoSwift

protocol EncryptionServiceProtocol {
    func createKey(_ salt: String) throws -> Array<UInt8>
    func encrypt(data: Data, key: Array<UInt8>) throws -> Data
    func decrypt(encrypted: Data, key: Array<UInt8>) throws -> Data
}

final class EncryptionService: EncryptionServiceProtocol {
    
    private let iv: Array<UInt8> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    private let pass = "<change-it-on-release>"
    
    func createKey(_ salt: String) throws -> Array<UInt8> {
        try PKCS5.PBKDF2(
            password: pass.bytes,
            salt: salt.bytes,
            iterations: 1024,
            keyLength: 32
        )
        .calculate()
    }
    
    func encrypt(data: Data, key: Array<UInt8>) throws -> Data {
        let aes = try AES(key: key, blockMode: CBC(iv: iv))
        return Data(try aes.encrypt(data.bytes))
    }
    
    func decrypt(encrypted: Data, key: Array<UInt8>) throws -> Data {
        let aes = try AES(key: key, blockMode: CBC(iv: iv))
        return Data(try aes.decrypt(encrypted.bytes))
    }
}
