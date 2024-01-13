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
            ScrollView {
                ForEach(presenter.messages) { message in
                    HStack {
                        let id = presenter.messages.firstIndex(of: message) ?? -2
                        MessageView(
                            message: message,
                            isFirst: presenter.messages[secured: id-1]?.sender != message.sender,
                            isLast: presenter.messages[secured: id+1]?.sender != message.sender,
                            isMine: message.sender == presenter.userId
                        )
                    }
                }
            }
            .padding(.horizontal, 16)
            
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
