//
//  SocketsService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import Starscream

protocol SocketsServiceProtocol {
    func connect(url: String, action: @escaping DataCallback)
    func disconnect()
    func send(_ data: Data)
}

final class SocketsService: SocketsServiceProtocol, WebSocketDelegate {

    private var socket: WebSocket?
    private var action: DataCallback?
    
    func connect(url: String, action: @escaping DataCallback) {
        let request = URLRequest(url: URL(string: url)!)
        self.action = action
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .disconnected, .peerClosed, .cancelled:
            socket?.connect()
        case .binary(let data):
            action?(data)
        default:
            print(event)
        }
    }

    func send(_ data: Data) {
        socket?.write(data: data) {
            self.action?(data)
        }
    }
    
    func disconnect() {
        socket?.disconnect()
    }
}
