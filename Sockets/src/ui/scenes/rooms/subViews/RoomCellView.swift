//
//  RoomCellView.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

struct RoomCellView: View {

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
        ZStack {
            AnimatedBorderView(
                color: color,
                shape: NgonShape(points: 6)
            )
            
            if let name = session?.name {
                Text(name)
                    .applyTextStyle(.h4, tint: color)
                    .multilineTextAlignment(.center)
                    .padding(8)
            }
        }
    }
}
