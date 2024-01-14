//
//  FeedbackViewModifier.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import SwiftUI

private struct FeedbackViewModifier: ViewModifier {
    
    private let publisher: StringPublisher
    
    @State private var message: String?
    
    init(_ publisher: StringPublisher) {
        self.publisher = publisher
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                if let message {
                    Text(message)
                        .applyTextStyle(.body, tint: .white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Color.gray2
                                .clipShape(
                                    RoundedRectangle(cornerSize: .s(8))
                                )
                        )
                        .padding(.bottom, 64)
                        .task {
                            try? await Task.sleep(nanoseconds: 5_000_000_000)
                            self.message = nil
                        }
                }
            }
            .transition(.push(from: .bottom))
            .animation(.easeIn,  value: message)
        }
        .onReceive(publisher) {
            self.message = $0
        }
    }
}

extension View {
    func feedbackSystem(_ publisher: StringPublisher) -> some View {
        self.modifier(
            FeedbackViewModifier(publisher)
        )
    }
}
