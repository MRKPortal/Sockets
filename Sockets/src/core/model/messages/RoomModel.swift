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
    let key: String
    
    init(name: String, key: String) {
        self.id = UUID().uuidString
        self.name = name
        self.key = key
    }
}
