//
//  SocketsApp.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

@main
struct SocketsApp: App {
    
    private let injector = ServicesInjector()
    
    var body: some Scene {
        WindowGroup {
            ContentView(injector: injector)
        }
    }
}

private struct ContentView: View {

    private let factory: DetailSceneFactory
    
    init(injector: ServicesInjectorProtocol) {
        factory = DetailSceneFactory(injector)
    }
    
    var body: some View {
        factory.build()
    }
}
