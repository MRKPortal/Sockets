//
//  AccessSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

final class AccessSceneFactory: Factory {
    private lazy var router = AccessSceneRouter(injector: injector, coordinator: coordinator)
    private lazy var interactor = AccessSceneInteractor(injector: injector)
    private lazy var presenter = AccessScenePresenter(interactor: interactor, router: router)
    
    override func build() -> AnyView {
        AnyView(AccessSceneView(presenter))
    }
}
