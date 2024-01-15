//
//  HiveView.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

struct HiveView<C: View>: View {
    
    private let distributor = UI.Hive.distributor
    private let animation: Animation = .bouncy(duration: 1, extraBounce: 0.5)

    @State private var enter: Bool = false

    @ViewBuilder let cellView: ((Int?, CGPoint) -> C)

    var body: some View {
        GeometryReader { reader in
            let side = reader.size.width / 3
            ZStack {
                Color.clear
                ForEach(Array(distributor.positionGroups.enumerated()), id: \.offset) { radius, group in
                    let delay = CGFloat(radius) * 0.15
                    ZStack {
                        ForEach(Array(group.enumerated()), id: \.offset) { offset, pos in
                            cellView(distributor.index(group: radius, index: offset), pos)
                                .transformEffect(.t(pos * side))
                        }
                    }
                    .scaleEffect(enter ? 1 : 0.5)
                    .animation(animation.delay(delay), value: enter)
                    .opacity(enter ? 1 : 0)
                    .animation(.linear.delay(delay), value: enter)
                    .zIndex(1)
                }
            }
        }
        .onAppear {
            enter.toggle()
        }
    }
}
