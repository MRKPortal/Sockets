//
//  FieldView.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

struct FieldView: View {
    
    @FocusState var focused: Bool
    
    let placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .leading) {
                if value.isEmpty {
                    Text(placeholder)
                        .applyTextStyle(.h4, tint: .gray3)
                }
                TextField("", text: $value)
                    .applyTextStyle(.h4)
                    .focused($focused)
                    .autocorrectionDisabled(true)
            }
            (focused || !value.isEmpty ? Color.base1 : .gray3)
                .frame(height: 1)
                .animation(.bouncy(duration: 1), value: focused)
        }
    }
}
