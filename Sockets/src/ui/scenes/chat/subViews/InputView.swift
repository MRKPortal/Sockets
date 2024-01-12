//
//  InputView.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct InputView: View {
    
    @Binding var value: String
    let sendAction: () -> Void

    @FocusState private var focused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Color.base1.frame(height: 1)
            HStack {
                TextField("", text: $value)
                    .focused($focused)
                    .foregroundColor(.base3)
                    .frame(minHeight: 48)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        Color.base0
                            .cornerRadius(16)
                    }
                    .padding(.vertical, 8)
                
                IconCircularAppButton(.mailSend) {
                    focused = false
                    sendAction()
                }
                .disabled(value.isEmpty)
                .frame(width: 48, height: 48)
                
            }
            .padding(.horizontal, 16)
        }
    }
}
