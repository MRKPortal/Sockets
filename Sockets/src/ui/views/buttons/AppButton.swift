//
//  AppButton.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

enum AppButtonStyle {

    case confirm, delete
    
    var backgroundColor: Color {
        switch self {
        case .delete: .red5
        default: .green3
        }
    }
}

struct AppButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    private let title: String
    private let action: VoidCallback?
    private let style: AppButtonStyle
    private let generator = UIImpactFeedbackGenerator(style: .light)

    init(_ title: String, style: AppButtonStyle = .confirm, action: VoidCallback?) {
        self.title = title
        self.action = action
        self.style = style
    }
    
    var body: some View {
        Button {
            generator.impactOccurred()
            action?()
        } label: {
            ZStack {
                background
                Text(title)
                    .applyTextStyle(.h1, tint: .base1)
            }
            .transition(.opacity)
            .animation(.easeIn(duration: 0.25), value: isEnabled)
            .cornerRadius(8)
        }
        .frame(height: 48)
        .buttonStyle(.bouncing)
    }
}

private extension AppButton {
    @ViewBuilder
    var background: some View {
        if isEnabled {
            style.backgroundColor
        } else {
            style.backgroundColor.opacity(0.25)
        }
    }
}
