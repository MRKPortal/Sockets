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
    
    init(_ session: RoomModel?) {
        self.session = session
    }
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                AngularGradient(
                    colors: colors,
                    center: .center,
                    angle: .degrees(degrees)
                )
                
                Color
                    .base1
                    .clipShape(shape)
                    .padding(6)
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

private extension RoomCellView {
    var colors: [Color] {
        let color: Color = session == nil ? .gray6 : .green5
        return [color, .clear, .clear, color]
    }
}
