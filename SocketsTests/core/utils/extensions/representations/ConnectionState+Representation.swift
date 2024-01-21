//
//  ConnectionState+Representation.swift
//  SocketsTests
//
//  Created by Marc Flores on 21/1/24.
//

import SwiftUI

extension ConnectionState {
    var color: Color {
        switch self {
        case .connected:
                .green3
        case .connecting:
                .orange3
        case .disconnected:
                .red3
        }
    }
}
