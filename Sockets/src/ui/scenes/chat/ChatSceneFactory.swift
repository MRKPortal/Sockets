//
//  ChatSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

final class ChatSceneFactory {

    private let injector: ServicesInjectorProtocol
    private let feedback = FeedbackSystem()
    private lazy var interactor = ChatSceneInteractor(injector, room: .init(name: "Room#1", key: "<roomName>"))
    private lazy var presenter = ChatScenePresenter(interactor: interactor, feedback: feedback)
    
    init(_ injector: ServicesInjectorProtocol) {
        self.injector = injector
    }
    
    func build() -> some View {
        AnyView(ChatSceneView(presenter))
    }
}
