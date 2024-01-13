//
//  SessionModel.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import Foundation

struct SessionModel: Codable {
    let username: String
    let url: String
    let id: String
    
    init(username: String, url: String) {
        self.username = username
        self.url = url
        self.id = UUID().uuidString
    }
}
