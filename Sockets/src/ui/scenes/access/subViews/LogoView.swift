//
//  LogoView.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

struct LogoView: View {
    
    @State private var degrees: Double = 0
    
    private let shape = NgonShape(points: 6)
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                AngularGradient(
                    colors: [.green1, .clear, .clear, .green1],
                    center: .center,
                    angle: .degrees(degrees)
                )
                
                Color
                    .base1
                    .clipShape(shape)
                    .padding(3)
                
                Image
                    .iconsSocket
                    .resizable()
                    .foregroundColor(Color.green1)
                    .scaledToFit()
                    .frame(size: .s(reader.size.width/2.3))
                    .rotationEffect(.degrees(-degrees))
            }
            .clipShape(shape)
            .onAppear {
                withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                    degrees = 360
                }
            }
        }
    }
}
