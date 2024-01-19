//
//  SocketsService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import Starscream

protocol SocketsServiceProtocol {

    var eventsPublisher: EventPublisher { get }

    func connect(url: String)
    func disconnect()
    func send(_ data: Data)
}

final class SocketsService: SocketsServiceProtocol, WebSocketDelegate {

    private var socket: WebSocket?
    
    private let subject = EventSubject()
    
    var eventsPublisher: EventPublisher {
        subject.eraseToAnyPublisher()
    }
    
    func connect(url: String) {
        let request = URLRequest(url: URL(string: url)!)
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected:
            subject.send(.connected)
        case .disconnected, .peerClosed, .cancelled:
            subject.send(.disconnect)
            socket?.connect()
        case .binary(let data):
            subject.send(.message(data))
        default:
            print(event)
        }
    }

    func send(_ data: Data) {
        socket?.write(data: data)
        subject.send(.message(data))
    }
    
    func disconnect() {
        socket?.disconnect()
    }
}
