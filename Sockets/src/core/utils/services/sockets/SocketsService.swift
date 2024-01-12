//
//  SocketsService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import Starscream

protocol SocketsServiceProtocol {
    func connect()
    func send(_ message: MessageModel)
}

final class SocketsService: NSObject, SocketsServiceProtocol, WebSocketDelegate {
    
    private let socket: WebSocket
    
    init(_ url: String) {
        let request = URLRequest(url: URL(string: url)!)
        socket = WebSocket(request: request)
        super.init()
        socket.delegate = self
    }
    
    func connect() {
        socket.connect()
    }

    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .text(let message):
            print("message", message)
        case .disconnected, .peerClosed, .cancelled:
            socket.connect()
        case .binary(let data):
            print(try? JSONDecoder().decode(MessageModel.self, from: data))
        default:
            print(event)
        }
    }
    
    func send(_ message: MessageModel) {
        let data = try! JSONEncoder().encode(message)
        self.socket.write(data: data) {
            print("completed")
        }
    }
}
