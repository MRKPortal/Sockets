//
//  EncryptionTests.swift
//  SocketsTests
//
//  Created by Marc Flores on 13/1/24.
//

import XCTest
@testable import Sockets

final class SocketsTests: XCTestCase {

    func testEncryption() throws {
        let encryption = EncryptionService()
        let key = try encryption.createKey(UUID().uuidString)
        let testingValue = UUID().uuidString
        let testingData = Data(testingValue.bytes)
        let encrypted = try encryption.encrypt(data: testingData, key: key)
        let decrypted = try encryption.decrypt(encrypted: encrypted, key: key)
        XCTAssertEqual(testingData, decrypted)
    }
    
    func testEncryptionDifferentSalts() throws {
        let encryption1 = EncryptionService()
        let key1 = try encryption1.createKey(UUID().uuidString)

        let encryption2 = EncryptionService()
        let key2 = try encryption2.createKey(UUID().uuidString)
        
        let testingValue = UUID().uuidString
        let testingData = Data(testingValue.bytes)
        
        let encrypted1 = try encryption1.encrypt(data: testingData, key: key1)
        let encrypted2 = try encryption2.encrypt(data: testingData, key: key2)

        XCTAssertNotEqual(encrypted1, encrypted2)
    }
    
    func testEncryptionEqualSalts() throws {
        let salt = UUID().uuidString
        let encryption1 = EncryptionService()
        let key1 = try encryption1.createKey(salt)

        let encryption2 = EncryptionService()
        let key2 = try encryption2.createKey(salt)
        
        let testingValue = UUID().uuidString
        let testingData = Data(testingValue.bytes)
        
        let encrypted1 = try encryption1.encrypt(data: testingData, key: key1)
        let encrypted2 = try encryption2.encrypt(data: testingData, key: key2)

        XCTAssertEqual(encrypted1, encrypted2)
    }
}
