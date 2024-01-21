//
//  SendButton.swift
//  Sockets
//
//  Created by Marc Flores on 21/1/24.
//

import SwiftUI

struct SendButton: View {
    
    private let state: ConnectionState
    private let action: VoidCallback
    
    init(state: ConnectionState, action: @escaping VoidCallback) {
        self.state = state
        self.action = action
    }
    
    var body: some View {
        Button {
            UI.Feedback.buttonHaptic.impactOccurred()
            action()
        } label: {
            Image
                .iconsSend
                .resizable()
                .foregroundColor(.white)
                .scaledToFit()
                .padding(10)
                .background(state.color)
                .clipShape(Circle())
        }
        .buttonStyle(.bouncing)
    }
}
