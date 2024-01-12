//
//  IconCircularAppButton.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct IconCircularAppButton: View {

    @Environment(\.isEnabled) private var isEnabled

    private let action: () -> Void
    private let icon: Image
    private let generator = UIImpactFeedbackGenerator(style: .light)

    init(_ icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button {
            generator.impactOccurred()
            action()
        } label: {
            GeometryReader { reader in
                icon
                    .resizable()
                    .foregroundColor(.white)
                    .scaledToFit()
                    .padding(reader.size.width/4)
                    .background(background)
            }
        }
        .buttonStyle(.bouncing)
    }
}

private extension IconCircularAppButton {
    @ViewBuilder
    var background: some View {
        Color.blue1
            .opacity(isEnabled ? 1 : 0.25)
            .clipShape(Circle())
            .animation(.bouncy, value: isEnabled)
    }
}
