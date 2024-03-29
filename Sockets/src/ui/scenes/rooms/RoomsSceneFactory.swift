//
//  RoomsSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

final class RoomsSceneFactory: Factory {

    private lazy var feedback = FeedbackSystem()
    private lazy var router = RoomsSceneRouter(injector: injector, coordinator: coordinator)
    private lazy var interactor = RoomsSceneInteractor(injector)
    private lazy var presenter = RoomsScenePresenter(interactor: interactor, router: router, feedback: feedback)
    
    override func build() -> AnyView {
        AnyView(RoomsSceneView(presenter))
    }
}
