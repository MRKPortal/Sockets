//
//  EncryptionService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import CryptoSwift

protocol EncryptionServiceProtocol {
    func encode(data: Data, key: Data) -> Data
    func decode(encrypted: Data, key: Data) -> Data
}

final class EncryptionService: EncryptionServiceProtocol {
    func encode(data: Data, key: Data) -> Data {
        fatalError()
    }
    
    func decode(encrypted: Data, key: Data) -> Data {
        fatalError()
    }    
}
