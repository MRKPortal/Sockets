//
//  ChatSceneView.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

struct ChatSceneView<P: ChatScenePresenterProtocol>: View {
    
    private let banners = [Ls.chatBannerEncryption, Ls.chatBannerInvite]
    
    @State private var text: String = ""
    
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
                        }
                    }
                    .onChange(of: presenter.messages.count) { _, value in
                        withAnimation {
                            scroll.scrollTo(bottom)
                        }
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .padding(.horizontal, 16)
            
            InputView(value: $text) {
                presenter.send(text)
                text = ""
            }
        }
        .feedbackSystem(presenter.feedbackPublisher)
    }
}
