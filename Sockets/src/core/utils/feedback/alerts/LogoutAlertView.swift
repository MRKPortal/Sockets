//
//  LogoutAlertView.swift
//  Sockets
//
//  Created by Marc Flores on 18/1/24.
//

import SwiftUI

struct LogoutAlertView: View {
    var body: some View {
        AnimatedBorderView(
            color: .red5,
            shape: RoundedRectangle(cornerSize: .s(16))
        )
        .frame(size: .s(200))
    }
}
