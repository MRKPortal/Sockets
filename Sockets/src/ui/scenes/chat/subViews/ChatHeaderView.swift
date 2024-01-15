//
//  ChatHeaderView.swift
//  Sockets
//
//  Created by Marc Flores on 14/1/24.
//

import SwiftUI

struct ChatHeaderView: View {
    @State private var pressing: Bool = false

    private let impact = UIImpactFeedbackGenerator(style: .heavy)
    private let title: String
    private let leftAction: VoidCallback
    private let holdAction: VoidCallback

    init(title: String, leftAction: @escaping VoidCallback, holdAction: @escaping VoidCallback) {
        self.title = title
        self.leftAction = leftAction
        self.holdAction = holdAction
    }
    
    var body: some View {
        ZStack {
            HStack {
                IconCircularAppButton(.iconsLeft, padding: 0, action: leftAction)
                    .frame(size: .s(40))
                Spacer()
                Text(title)
                    .applyTextStyle(.body)
                    .scaleEffect(pressing ? 0.9 : 1)
                    .onLongPressGesture(minimumDuration: 0.5) {
                        impact.impactOccurred()
                        holdAction()
                    } onPressingChanged: { pressing in
                        withAnimation {
                            self.pressing = pressing
                        }
                    }
                Spacer()
                Spacer()
                    .frame(size: .s(40))
            }
            .ignoresSafeArea(edges: .top)
            .frame(height: 48)
            .background(Color.green3)
        }
    }
}
