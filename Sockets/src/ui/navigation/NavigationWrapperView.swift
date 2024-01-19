//
//  NavigationWrapperView.swift
//  Sockets
//
//  Created by Marc Flores on 16/1/24.
//

import SwiftUI

struct NavigationWrapperView: View {
    
    @ObservedObject private var navCoordinator: NavigationCoordinator
    
    init(coordinator: NavigationCoordinator) {
        self.navCoordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                Color.base2
                    .edgesIgnoringSafeArea(.all)
                ZStack {
                    ForEach(navCoordinator.path) { factory in
                        let last = navCoordinator.path.last
                        factory.build()
                            .zIndex(last == factory ? 1 : 0)
                            .opacity(last == factory ? 1 : 0)
                            .offset(x: reader.size.width * (last == factory ? 0 : -1))
                            .transition(
                                .move(edge: .trailing)
                                .combined(with: .opacity)
                            )
                    }
                }
                .animation(.bouncy, value: navCoordinator.path)
            }
        }
    }
}

