//
//  IconCircularAppButton.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct IconCircularAppButton: View {

    enum Style {
        case normal, destructive
        
        var tint: Color {
            switch self {
            case .normal: .white
            case .destructive: .red5
            }
        }
        
        var background: Color {
            switch self {
            case .normal: .green3
            case .destructive: .clear
            }
        }
    }
    
    @Environment(\.isEnabled) private var isEnabled

    private let action: () -> Void
    private let icon: Image
    private let style: Self.Style
    private let padding: CGFloat

    init(_ icon: Image, style: Self.Style, padding: CGFloat = 8, action: @escaping () -> Void) {
        self.icon = icon
        self.style = style
        self.action = action
        self.padding = padding
    }
    
    var body: some View {
        Button {
            UI.Feedback.buttonHaptic.impactOccurred()
            action()
        } label: {
            GeometryReader { reader in
                icon
                    .resizable()
                    .foregroundColor(style.tint)
                    .scaledToFit()
                    .padding(padding)
                    .background(background)
            }
        }
        .buttonStyle(.bouncing)
    }
}

private extension IconCircularAppButton {
    @ViewBuilder
    var background: some View {
        style.background
            .opacity(isEnabled ? 1 : 0.25)
            .clipShape(Circle())
            .animation(.bouncy, value: isEnabled)
    }
}
