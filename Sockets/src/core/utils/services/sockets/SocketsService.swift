//
//  SocketsService.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Foundation
import Starscream

protocol SocketsServiceProtocol {
    
    var connectionPublisher: ConnectionPublisher { get }
    var dataPublisher: DataPublisher { get }
    
    func connect(url: String)
    func disconnect()
    func send(_ data: Data)
}

final class SocketsService: SocketsServiceProtocol, WebSocketDelegate {
    
    private var socket: WebSocket?
    
    private let connectionSubject = ConnectionSubject(.disconnected)
    private let dataSubject = DataSubject()
    
    var dataPublisher: DataPublisher {
        dataSubject.eraseToAnyPublisher()
    }
    
    var connectionPublisher: ConnectionPublisher {
        connectionSubject.eraseToAnyPublisher()
    }
    
    func connect(url: String) {
        let request = URLRequest(url: URL(string: url)!)
        socket = WebSocket(request: request)
        connectionSubject.send(.connecting)
        socket?.delegate = self
        socket?.connect()
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .pong, 
                .connected:
            connectionSubject.send(.connected)
        case .disconnected, 
                .peerClosed,
                .cancelled,
                .error:
            connectionSubject.send(.disconnected)
        case .reconnectSuggested(let value):
            connectionSubject.send(value ? .connecting : .disconnected)
            if value {
                socket?.connect()
            }
        case .binary(let data):
            dataSubject.send(data)
        default:
            break
        }
    }
    
    func send(_ data: Data) {
        socket?.write(data: data)
        dataSubject.send(data)
    }
    
    func disconnect() {
        socket?.disconnect()
    }
}
