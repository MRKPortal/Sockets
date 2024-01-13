//
//  AccessSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import SwiftUI

final class AccessSceneFactory {

    private let injector: ServicesInjectorProtocol
    
    private lazy var interactor = AccessSceneInteractor(injector: injector)
    private lazy var presenter = AccessScenePresenter(interactor: interactor)
    
    init(_ injector: ServicesInjectorProtocol) {
        self.injector = injector
    }
    
    func build() -> some View {
        AnyView(AccessSceneView(presenter))
    }
}
