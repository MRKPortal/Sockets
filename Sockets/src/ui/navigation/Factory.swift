//
//  Factory.swift
//  Sockets
//
//  Created by Marc Flores on 16/1/24.
//

import SwiftUI

class Factory: Identifiable, Equatable {

    static func == (lhs: Factory, rhs: Factory) -> Bool {
        lhs.id == rhs.id
    }
    
    let coordinator: NavigationCoordinator
    let injector: ServicesInjectorProtocol

    init(coordinator: NavigationCoordinator, injector: ServicesInjectorProtocol) {
        self.coordinator = coordinator
        self.injector = injector
    }
    
    let id: String = UUID().uuidString
    
    func build() -> AnyView {
        //OVERRIDE
        fatalError()
    }
}
