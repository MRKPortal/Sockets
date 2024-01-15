//
//  RoomsSceneFactory.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

final class RoomsSceneFactory {

    private let injector: ServicesInjectorProtocol

    private lazy var presenter = RoomsScenePresenter()
    
    init(_ injector: ServicesInjectorProtocol) {
        self.injector = injector
    }
    
    func build() -> some View {
        AnyView(RoomsSceneView(presenter))
    }
}
