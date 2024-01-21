//
//  ConnectionView.swift
//  Sockets
//
//  Created by Marc Flores on 21/1/24.
//

import SwiftUI

struct ConnectionView: View {
    
    private let publisher: ConnectionPublisher
    private let url: String

    @State private var degrees: Double = 0
    @State private var message: String?
    @State private var state: ConnectionState = .disconnected
    
    init(publisher: ConnectionPublisher, url: String) {
        self.publisher = publisher
        self.url = url
    }
    
    var body: some View {
        HStack {
            if let message {
                Text(message)
                    .applyTextStyle(.body, tint: .white)
                    .lineLimit(1)
            }
            Image
                .iconsSocket
                .resizable()
                .foregroundColor(.white)
                .rotationEffect(.degrees(state == .disconnected ? 0 : degrees))
                .frame(size: .s(16))
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background {
            state
                .color
                .frame(minWidth: 32, minHeight: 32)
                .clipShape(Capsule())
        }
        .onReceive(publisher) { state in
            withAnimation {
                self.state = state
                self.message = state.message
            }
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                degrees = 360
            }
        }
    }
    
}

private extension ConnectionState {
    var message: String? {
        switch self {
        case .connected:
            nil
        case .connecting:
            Ls.genericConnecting
        case .disconnected:
            Ls.genericDisconnected
        }
    }
}
