//
//  Identifiers.swift
//  Sockets
//
//  Created by Marc Flores on 27/1/24.
//

import Foundation

enum Identifiers {
    enum Access {
        static let connectBtn = "access.scene.connect.btn"
        static let serverLbl = "access.scene.server.lbl"
        static let nameLbl = "access.scene.name.lbl"
    }
    
    enum Rooms {
        static let addBtn = "rooms.scene.add.btn"
        static let logoutBtn = "rooms.scene.logout.btn"
        static func roomCell(_ index: Int?) -> String {
            var id = "rooms.scene.room.cell"
            if let index { id += "[\(index)]" }
            return id
        }
    }
    
    enum Chat {
        
    }
    
    enum Alerts {
        static let logoutConfirmBtn = "dialog.logout.confirm.btn"
        
        static let createRoomNameLbl = "dialog.create.room.name.lbl"
        static let createRoomKeyLbl = "dialog.create.room.key.lbl"
        static let createRoomBtn = "dialog.create.room.btn"
    }
}
