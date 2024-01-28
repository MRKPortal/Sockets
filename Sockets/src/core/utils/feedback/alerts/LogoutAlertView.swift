//
//  LogoutAlertView.swift
//  Sockets
//
//  Created by Marc Flores on 18/1/24.
//

import SwiftUI

struct LogoutAlertView: View {
    
    let action: VoidCallback
    let dismiss: VoidCallback
    
    init(action: @escaping VoidCallback, dismiss: @escaping VoidCallback) {
        self.action = action
        self.dismiss = dismiss
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(Ls.logoutTitle)
                .applyTextStyle(.h2, tint: .red5)
            
            Text(Ls.logoutDescription)
                .applyTextStyle(.body, tint: .red4)
                .multilineTextAlignment(.center)
            
            HStack {
                AppButton(
                    Ls.genericCancel,
                    style: .normal,
                    action: dismiss
                )
                
                AppButton(
                    Ls.genericYes,
                    style: .delete
                ) {
                    action()
                    dismiss()
                }
                .accessibilityIdentifier(Identifiers.Alerts.logoutConfirmBtn)
            }
        }
        .padding(24)
        .background {
            AnimatedBorderView(
                color: .red5,
                shape: RoundedRectangle(cornerSize: .s(16))
            )
        }
    }
}
