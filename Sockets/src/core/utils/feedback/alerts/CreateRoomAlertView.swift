//
//  CreateRoomAlertView.swift
//  Sockets
//
//  Created by Marc Flores on 18/1/24.
//

import SwiftUI

struct CreateRoomAlertView: View {
    
    var body: some View {
        AnimatedBorderView(
            color: .green5,
            shape: RoundedRectangle(cornerSize: .s(16))
        )        
        .frame(size: .s(200))
    }
}
