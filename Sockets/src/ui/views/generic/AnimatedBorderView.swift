//
//  AnimatedBorderView.swift
//  Sockets
//
//  Created by Marc Flores on 18/1/24.
//

import SwiftUI

struct AnimatedBorderView<S: Shape>: View {
    
    private let color: Color
    private let shape: S
    
    @State private var degrees: Double = 0
    
    init(color: Color, shape: S) {
        self.color = color
        self.shape = shape
    }
    
    var body: some View {
        ZStack {
            AngularGradient(
                colors: [color, .clear, .clear, color],
                center: .center,
                angle: .degrees(degrees)
            )
            
            Color
                .base2
                .clipShape(shape)
                .padding(3)
        }
        .clipShape(shape)
        .onAppear {
            withAnimation(.linear(duration: 2)
                .repeatForever(autoreverses: false)) {
                    degrees = 360
                }
        }
    }
}
