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
        HStack(alignment: .bottom, spacing: 4) {
            avatarArea(true)
            messageContent
                .padding(isMine ? .leading: .trailing, 32)
            avatarArea(false)
        }
    }
}

private extension MessageView {
    @ViewBuilder
    func avatarArea(_ value: Bool) -> some View {
        if isMine == value {
            Spacer()
        } else if isLast{
            GravatarView(message.sender)
                .frame(size: .s(24))
        } else {
            Spacer()
                .frame(width: 24)
        }
    }
    
    @ViewBuilder
    var messageContent: some View {
        VStack(alignment: .leading) {
            if isFirst && !isMine {
                Text(message.alias)
                    .applyTextStyle(.h4, tint: UI.Colors.options[message.id])
            }
            
            Text(message.message)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .applyTextStyle(.body)
        }
        .padding(8)
        .background (
            (isMine ? Color.green3 : .zinc1)
                .cornerRadius(8)
        )
        .padding(.top, isFirst ? 8 : 0)
    }
}
