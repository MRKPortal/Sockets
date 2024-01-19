//
//  SocketEvent.swift
//  Sockets
//
//  Created by Marc Flores on 19/1/24.
//

import Foundation

enum SocketEvent {
    case disconnect
    case connected
    case message(Data)
}
