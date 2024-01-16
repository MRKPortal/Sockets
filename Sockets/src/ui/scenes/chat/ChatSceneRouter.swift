//
//  ChatSceneRouter.swift
//  Sockets
//
//  Created by Marc Flores on 17/1/24.
//

import Foundation

protocol ChatSceneRouterProtocol {
    func pop()
}

final class ChatSceneRouter: ChatSceneRouterProtocol {

    private let coordinator: NavigationCoordinator
    
    init(coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
    }
 
    //MARK: - ChatSceneRouterProtocol
    func pop() {
        coordinator.pop()
    }
}
