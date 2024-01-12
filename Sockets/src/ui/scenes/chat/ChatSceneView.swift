//
//  ChatSceneView.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct ChatSceneView<P: ChatScenePresenterProtocol>: View {
    
    @State private var text: String = ""
    @ObservedObject private var presenter: P
    
    init(_ presenter: P) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack {
            Spacer()
            InputView(value: $text) {
                presenter.send(text)
                text = ""
            }
        }
        .onAppear {
            presenter.connect()
        }
    }
}