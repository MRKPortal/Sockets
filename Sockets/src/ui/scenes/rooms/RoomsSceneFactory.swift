//
//  RoomsSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

final class RoomsSceneFactory: Factory {

    private lazy var router = RoomsSceneRouter(injector: injector, coordinator: coordinator)
    private lazy var presenter = RoomsScenePresenter(router: router)
    
    override func build() -> AnyView {
        AnyView(RoomsSceneView(presenter))
    }
}
