//
//  MessageView.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

struct MessageView: View {
    
    private let message: MessageModel
    private let isFirst: Bool
    private let isLast: Bool
    private let isMine: Bool
    
    init(message: MessageModel, isFirst: Bool, isLast: Bool, isMine: Bool) {
        self.message = message
        self.isFirst = isFirst
        self.isLast = isLast
        self.isMine = isMine
    }
    
    var body: some View {
        HStack {
            if isMine {
                Spacer()
            }
            
            messageContent
                .padding(isMine ? .leading: .trailing, 32)
            
            if !isMine {
                Spacer()
            }
        }
    }
}

private extension MessageView {
    
    var tintColor: Color {
        UI.Messages.colors [
            message.sender.number % UI.Messages.colors.count
        ]
    }
    
    @ViewBuilder
    var messageContent: some View {
        VStack(alignment: .leading) {
            if isFirst && !isMine {
                Text(message.alias)
                    .applyTextStyle(.h4, tint: tintColor)
            }
            
            Text(message.message)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .applyTextStyle(.body)
        }
        .padding(8)
        .background (
            (isMine ? Color.green5 : .gray4)
                .cornerRadius(8)
        )
        .padding(.top, isFirst ? 8 : 0)
    }
}
