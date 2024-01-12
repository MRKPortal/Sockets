//
//  BouncingButtonStyle.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct BouncingButtonStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        GeometryReader { reader in
            configuration
                .label
                .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}

extension ButtonStyle where Self == BouncingButtonStyle {
    static var bouncing: Self {
        Self.init()
    }
}
