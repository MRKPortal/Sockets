//
//  RoomModel.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import Foundation

struct RoomModel: Codable, Identifiable, Equatable {
    var id: String {
        name
    }
    let name: String
    let key: String
}
