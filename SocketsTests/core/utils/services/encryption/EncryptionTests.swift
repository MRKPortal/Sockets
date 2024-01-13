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
        try encryption.configureKey(UUID().uuidString)
        let testingValue = UUID().uuidString
        let testingData = Data(testingValue.bytes)
        let encrypted = try encryption.encrypt(data: testingData)
        let decrypted = try encryption.decrypt(encrypted: encrypted)
        XCTAssertEqual(testingData, decrypted)
    }
    
    func testEncryptionDifferentSalts() throws {
        let encryption1 = EncryptionService()
        try encryption1.configureKey(UUID().uuidString)

        let encryption2 = EncryptionService()
        try encryption2.configureKey(UUID().uuidString)
        
        let testingValue = UUID().uuidString
        let testingData = Data(testingValue.bytes)
        
        let encrypted1 = try encryption1.encrypt(data: testingData)
        let encrypted2 = try encryption2.encrypt(data: testingData)

        XCTAssertNotEqual(encrypted1, encrypted2)
    }
    
    func testEncryptionEqualSalts() throws {
        let salt = UUID().uuidString
        let encryption1 = EncryptionService()
        try encryption1.configureKey(salt)

        let encryption2 = EncryptionService()
        try encryption2.configureKey(salt)
        
        let testingValue = UUID().uuidString
        let testingData = Data(testingValue.bytes)
        
        let encrypted1 = try encryption1.encrypt(data: testingData)
        let encrypted2 = try encryption2.encrypt(data: testingData)

        XCTAssertEqual(encrypted1, encrypted2)
    }
}
