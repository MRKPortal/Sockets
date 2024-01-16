//
//  ChatSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

final class ChatSceneFactory: Factory {

    private let room: RoomModel
    private let feedback = FeedbackSystem()
    private lazy var interactor = ChatSceneInteractor(injector, room: room)
    private lazy var router = ChatSceneRouter(coordinator: coordinator)
    private lazy var presenter = ChatScenePresenter(interactor: interactor, router: router, feedback: feedback)
    
    init(room: RoomModel, coordinator: NavigationCoordinator, injector: ServicesInjectorProtocol) {
        self.room = room
        super.init(coordinator: coordinator, injector: injector)
    }
    
    override func build() -> AnyView {
        AnyView(ChatSceneView(presenter))
    }
}
