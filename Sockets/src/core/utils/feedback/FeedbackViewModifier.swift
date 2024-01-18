//
//  FeedbackViewModifier.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import SwiftUI

private struct FeedbackViewModifier: ViewModifier {
    
    private let publisher: FeedbackPublisher
    
    @State private var toast: String?
    @State private var alert: CustomAlert?
    
    init(_ publisher: FeedbackPublisher) {
        self.publisher = publisher
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            //ALERT
            ZStack {
                Color
                    .black
                    .ignoresSafeArea()
                    .opacity(alert == nil ? 0 : 0.7)
                    .animation(.bouncy.delay(0.25), value: alert == nil)
                    .zIndex(1)
                    .onTapGesture {
                        self.alert = nil
                    }
                
                if let alert {
                    Group {
                        switch alert {
                        case .createRoom(let doubleStringCallback):
                            CreateRoomAlertView()
                        case .logOut(let voidCallback):
                            LogoutAlertView()
                        }
                    }
                    .zIndex(2)
                    .transition(
                        .push(from: .top)
                        .animation(.bouncy)
                    )
                }
            }
            .animation(.default, value: self.alert == nil)
            
            //TOAST
            VStack {
                Spacer()
                if let toast {
                    Text(toast)
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
                            self.toast = nil
                        }
                }
            }
            .transition(.push(from: .bottom))
            .animation(.easeIn,  value: toast)
        }
        .onReceive(publisher) { feedback in
            switch feedback {
            case .toast(let toast):
                self.toast = toast
            case .alert(let alert):
                self.alert = alert
            }
        }
    }
}

extension View {
    func feedbackSystem(_ publisher: FeedbackPublisher) -> some View {
        self.modifier(
            FeedbackViewModifier(publisher)
        )
    }
}
