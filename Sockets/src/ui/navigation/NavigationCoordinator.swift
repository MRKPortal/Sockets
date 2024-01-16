//
//  NavigationCoordinator.swift
//  Sockets
//
//  Created by Marc Flores on 16/1/24.
//

import SwiftUI

final class NavigationCoordinator: ObservableObject {

    @Published var path: [Factory] = []

    //MARK: PUSH

    func pushView(_ factory: Factory) {
        path.append(
            factory
        )
    }
    
    func pop() {
        guard path.count > 1 else {
            return
        }

        path.removeLast()
    }
}
