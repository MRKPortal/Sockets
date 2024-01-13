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
            Text(Ls.appName)
                .foregroundStyle(.base2)
            Spacer()
        }
    }
}
