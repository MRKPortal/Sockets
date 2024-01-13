//
//  EncryptionService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import CryptoSwift

protocol EncryptionServiceProtocol {
    func configureKey(_ salt: String) throws
    func encrypt(data: Data) throws -> Data
    func decrypt(encrypted: Data) throws -> Data
}

final class EncryptionService: EncryptionServiceProtocol {
    
    private let iv: Array<UInt8> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    private let pass = "<change-it-on-release>"
    
    private var key: Array<UInt8> = []
    
    func configureKey(_ salt: String) throws {
        key = try PKCS5.PBKDF2(
            password: pass.bytes,
            salt: salt.bytes,
            iterations: 1024,
            keyLength: 32
        )
        .calculate()
    }
    
    func encrypt(data: Data) throws -> Data {
        let aes = try AES(key: key, blockMode: CBC(iv: iv))
        return Data(try aes.encrypt(data.bytes))
    }
    
    func decrypt(encrypted: Data) throws -> Data {
        let aes = try AES(key: key, blockMode: CBC(iv: iv))
        return Data(try aes.decrypt(encrypted.bytes))
    }
}
