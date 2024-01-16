//
//  RoomCellView.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

struct RoomCellView: View {
    @State private var degrees: Double = 0
    
    private let shape = NgonShape(points: 6)
    private let session: RoomModel?
    private let color: Color
    
    init(_ session: RoomModel?) {
        self.session = session
        if let id = session?.id {
            color = UI.Colors.options[id]
        } else {
            color = .gray6
        }
    }
    
    var body: some View {
        GeometryReader { reader in
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
                
                if let name = session?.name {
                    Text(name)
                        .applyTextStyle(.h4, tint: color)
                        .multilineTextAlignment(.center)
                        .padding(8)
                }
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
}
