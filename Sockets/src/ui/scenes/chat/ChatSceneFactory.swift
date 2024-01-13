//
//  ChatSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

final class ChatSceneFactory {

    private let injector: ServicesInjectorProtocol
    
    private lazy var interactor = ChatSceneInteractor(injector)
    private lazy var presenter = ChatScenePresenter(interactor: interactor)
    
    init(_ injector: ServicesInjectorProtocol) {
        self.injector = injector
    }
    
    func build() -> some View {
        AnyView(ChatSceneView(presenter))
    }
}
