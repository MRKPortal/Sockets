//
//  CreateRoomAlertView.swift
//  Sockets
//
//  Created by Marc Flores on 18/1/24.
//

import SwiftUI

struct CreateRoomAlertView: View {
    
    @State private var name: String = ""
    @State private var password: String = ""
    
    private let outputCallback: DoubleStringCallback
    private let dismissCallback: VoidCallback

    init(outputCallback: @escaping DoubleStringCallback, dismissCallback: @escaping VoidCallback) {
        self.outputCallback = outputCallback
        self.dismissCallback = dismissCallback
    }
    
    var body: some View {
        VStack(spacing: 16) {

            Text(Ls.alertEnterTitle)
                .applyTextStyle(.h2)
            
            Text(Ls.alertEnterDescription)
                .applyTextStyle(.body, tint: .gray5)
                .multilineTextAlignment(.center)

            FieldView(
                placeholder: Ls.createRoomPlaceholder,
                value: $name
            )
            .accessibilityIdentifier(Identifiers.Alerts.createRoomNameLbl)

            FieldView(
                placeholder: Ls.createPasswordPlaceholder,
                value: $password
            )
            .accessibilityIdentifier(Identifiers.Alerts.createRoomKeyLbl)

            AppButton(
                Ls.actionEnter.uppercased(),
                action: didTapCreate
            )
            .disabled(name.isEmpty || password.isEmpty)
            .accessibilityIdentifier(Identifiers.Alerts.createRoomBtn)
        }
        .padding(24)
        .background {
            AnimatedBorderView(
                color: .green5,
                shape: RoundedRectangle(cornerSize: .s(16))
            )
        }
    }
}

private extension CreateRoomAlertView {
    func didTapCreate() {
        outputCallback(name, password)
        dismissCallback()
    }
}
