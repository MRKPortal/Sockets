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
    func send(_ data: Data) throws
}

final class SocketsService: SocketsServiceProtocol, WebSocketDelegate {
    
    private var socket: WebSocket?
    
    @Published private var connectionState: ConnectionState = .disconnected

    private let dataSubject = DataSubject()
    
    var dataPublisher: DataPublisher {
        dataSubject.eraseToAnyPublisher()
    }
    
    var connectionPublisher: ConnectionPublisher {
        $connectionState
            .eraseToAnyPublisher()
    }
    
    func connect(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        connectionState = .connecting
        socket?.delegate = self
        socket?.connect()
    }
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .pong, 
                .connected:
            connectionState = .connected
        case .disconnected,
                .peerClosed,
                .cancelled,
                .error:
            connectionState = .disconnected
        case .reconnectSuggested(let value):
            connectionState = value ? .connecting : .disconnected
            if value {
                socket?.connect()
            }
        case .binary(let data):
            dataSubject.send(data)
        default:
            break
        }
    }
    
    func send(_ data: Data) throws {
        guard connectionState == .connected else {
            throw SocketsError.notConnected
        }

        socket?.write(data: data)
        dataSubject.send(data)
    }
    
    func disconnect() {
        socket?.disconnect()
    }
}
