//
//  MessageModel.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

struct MessageModel: Codable, Identifiable, Equatable {
    let id: String
    let alias: String
    let sender: String
    let message: String
    let date: Date
    
    init(sender: String, alias: String, message: String) {
        self.id = UUID().uuidString
        self.sender = sender
        self.alias = alias
        self.message = message
        self.date = .now
    }
}
