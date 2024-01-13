//
//  MessageModel.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation

struct MessageModel: Codable, Identifiable {
    let id: String
    let message: String
    let date: Date
    
    init(_ message: String) {
        self.id = UUID().uuidString
        self.message = message
        self.date = .now
    }
}
