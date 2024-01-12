//
//  KeyboardPushedModifier.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI
import Combine

private struct KeyboardPushedModifier: ViewModifier {
    
    @State private var offsetY: CGFloat = 0
    
    let multiplier: CGFloat
    
    private let eventPublisher: AnyPublisher<CGFloat, Never> = AppEvents.main.keyBoardWillHide
        .merge(with:AppEvents.main.keyBoardWillShow)
        .eraseToAnyPublisher()
    
    func body(content: Content) -> some View {
        content
            .offset(y: -offsetY)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onReceive(eventPublisher) { value in
                withAnimation {
                    self.offsetY = value * multiplier
                }
            }
    }
}

extension View {
    func keyboardPushed(multiplier: CGFloat = 1) -> some View {
        self.modifier(
            KeyboardPushedModifier(multiplier: multiplier)
        )
    }
}
