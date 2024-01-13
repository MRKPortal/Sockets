//
//  SocketsService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import Starscream

protocol SocketsServiceProtocol {
    func connect(action: @escaping DataCallback)
    func send(_ data: Data)
}

final class SocketsService: NSObject, SocketsServiceProtocol, WebSocketDelegate {
    
    private let socket: WebSocket
    private var action: DataCallback?

    init(_ url: String) {
        let request = URLRequest(url: URL(string: url)!)
        socket = WebSocket(request: request)
        super.init()
        socket.delegate = self
    }
    
    func connect(action: @escaping (Data) -> ()) {
        socket.connect()
        self.action = action
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .disconnected, .peerClosed, .cancelled:
            socket.connect()
        case .binary(let data):
            action?(data)
        default:
            print(event)
        }
    }
    func send(_ data: Data) {
        self.socket.write(data: data) {
            self.action?(data)
        }
    }
}
