//
//  InputView.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct InputView: View {
    @FocusState private var inputFocus: Bool
    @Binding var value: String

    let state: ConnectionState
    let sendAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Color.base0.frame(height: 1)
            HStack {
                TextField("  ", text: $value)
                    .frame(minHeight: 32)
                    .focused($inputFocus)
                    .foregroundColor(.base3)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        Color.base0
                            .cornerRadius(16)
                    }
                    .padding(.vertical, 8)
                    .onTapGesture {
                        inputFocus = true
                    }
                SendButton(
                    state: state,
                    action: sendAction
                )
                .disabled(value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .frame(size: .s(32))
                
            }
            .padding(.horizontal, 16)
        }
    }
}
