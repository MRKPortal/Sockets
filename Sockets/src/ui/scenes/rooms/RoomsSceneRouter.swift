//
//  RoomsSceneRouter.swift
//  Sockets
//
//  Created by Marc Flores on 17/1/24.
//

import Foundation

protocol RoomsSceneRouterProtocol {
    func openChat(room: RoomModel)
    func pop()
}

final class RoomsSceneRouter: RoomsSceneRouterProtocol {
    
    private let injector: ServicesInjectorProtocol
    private let coordinator: NavigationCoordinator
    
    init(injector: ServicesInjectorProtocol, coordinator: NavigationCoordinator) {
        self.injector = injector
        self.coordinator = coordinator
    }
 
    //MARK: - RoomsSceneRouterProtocol
    func openChat(room: RoomModel) {
        coordinator.pushView(
            ChatSceneFactory(
                room: room,
                coordinator: coordinator,
                injector: injector
            )
        )
    }
    
    func pop() {
        coordinator.pop()
    }
}
