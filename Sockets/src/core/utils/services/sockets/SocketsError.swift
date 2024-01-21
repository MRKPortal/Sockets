//
//  SocketsError.swift
//  Sockets
//
//  Created by Marc Flores on 21/1/24.
//

import Foundation

enum SocketsError: LocalizedError {
    case notConnected
    
    var errorDescription: String? {
        Ls.errorMessageNotSend
    }
}
