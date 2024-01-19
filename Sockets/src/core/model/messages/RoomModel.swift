//
//  RoomModel.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Foundation

struct RoomModel: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let password: String
    let key: Array<UInt8>
    
    init(name: String, password: String, key: Array<UInt8>) {
        self.id = UUID().uuidString
        self.name = name
        self.password = password
        self.key = key
    }
}
