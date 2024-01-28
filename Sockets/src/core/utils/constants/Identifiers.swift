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
        static let serverTF = "access.scene.server.tf"
        static let nameTF = "access.scene.name.tf"
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
        static let sendBtn = "chat.scene.send.btn"
        static let inputTF = "chat.scene.input.tf"
        static let titleLbl = "chat.scene.title.lbl"
        static let messageContentLbl = "chat.scene.message.content.lbl"
        static let backBtn = "chat.scene.back.btn"
    }
    
    enum Alerts {
        static let logoutConfirmBtn = "alert.logout.confirm.btn"
        
        static let createRoomNameTF = "alert.create.room.name.tf"
        static let createRoomKeyTF = "alert.create.room.key.tf"
        static let createRoomBtn = "alert.create.room.btn"
        static let toastLbl = "alert.toast.message.lbl"
    }
}
