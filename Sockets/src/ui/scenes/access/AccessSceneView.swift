//
//  AccessSceneView.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

struct AccessSceneView<P: AccessScenePresenterProtocol>: View {
    
    @ObservedObject private var presenter: P
    
    init(_ presenter: P) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            LogoView()
                .frame(width: 200, height: 200)
            Text(Ls.appName.uppercased())
                .applyTextStyle(.h1)
            
            VStack(spacing: 16) {
                FieldView(
                    placeholder: Ls.accessUsernamePlaceholder,
                    value: $presenter.username
                )
                .accessibilityIdentifier(Identifiers.Access.nameTF)

                FieldView(
                    placeholder: Ls.accessServerPlaceholder,
                    value: $presenter.url
                )
                .accessibilityIdentifier(Identifiers.Access.serverTF)
            }
            
            Spacer()
            if !presenter.url.isEmpty, !presenter.username.isEmpty {
                AppButton(Ls.actionConnect.uppercased()) {
                    presenter.connect()
                }
                .accessibilityIdentifier(Identifiers.Access.connectBtn)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.bouncy, value: !presenter.url.isEmpty && !presenter.username.isEmpty)
        .padding(.horizontal, 32)
        .padding(.bottom, 8)
    }
}
