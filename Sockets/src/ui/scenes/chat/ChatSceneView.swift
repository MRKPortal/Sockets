//
//  ChatSceneView.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct ChatSceneView<P: ChatScenePresenterProtocol>: View {
    
    private let banners = [Ls.chatBannerEncryption, Ls.chatBannerInvite]
    
    @ObservedObject private var presenter: P
    @Namespace private var bottom
    @Namespace private var cell
    
    init(_ presenter: P) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ChatHeaderView(
                title: presenter.title,
                leftAction: presenter.didTapBack,
                holdAction: presenter.didTapCopyPrivate
            )
            
            ScrollViewReader { scroll in
                ScrollView {
                    //PADDING
                    Spacer()
                        .frame(height: 16)

                    //BANNERS
                    ForEach(banners, id: \.self) {
                        BannerView($0)
                    }

                    //MESSAGES
                    ForEach(presenter.messages) { message in
                        HStack {
                            let id = presenter.messages.firstIndex(of: message) ?? -2
                            let isMine = message.sender == presenter.userId
                            let lastMessage = presenter.messages.last == message
                            MessageView(
                                message: message,
                                isFirst: presenter.messages[secured: id-1]?.sender != message.sender,
                                isLast: presenter.messages[secured: id+1]?.sender != message.sender,
                                isMine: isMine
                            )
                            .id(lastMessage ? bottom : cell)
                            .accessibilityIdentifier(Identifiers.Chat.messageContentLbl)
                        }
                    }
                    .onChange(of: presenter.messages.count) { _, value in
                        withAnimation {
                            scroll.scrollTo(bottom)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            
            InputView(
                value: $presenter.message,
                state: presenter.state,
                sendAction: presenter.send
            )
            .animation(.bouncy, value: presenter.state)
        }
        .feedbackSystem(presenter.feedbackPublisher)
    }
}
