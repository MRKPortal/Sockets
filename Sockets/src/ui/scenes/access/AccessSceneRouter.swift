//
//  AccessSceneRouter.swift
//  Sockets
//
//  Created by Marc Flores on 17/1/24.
//

import Foundation

protocol AccessSceneRouterProtocol {
    func displayRooms()
}

final class AccessSceneRouter: AccessSceneRouterProtocol {
    
    private let injector: ServicesInjectorProtocol
    private let coordinator: NavigationCoordinator
    
    init(injector: ServicesInjectorProtocol, coordinator: NavigationCoordinator) {
        self.injector = injector
        self.coordinator = coordinator
    }
 
    //MARK: - AccessSceneRouterProtocol
    func displayRooms() {
        coordinator.pushView(
            RoomsSceneFactory(
                coordinator: coordinator,
                injector: injector
            )
        )
    }
}
