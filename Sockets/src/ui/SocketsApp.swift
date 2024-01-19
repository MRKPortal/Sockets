//
//  SocketsApp.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import SwiftUI

@main
struct SocketsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private struct ContentView: View {
    private let injector = ServicesInjector()
    private var navCoordinator = NavigationCoordinator()
    
    var body: some View {
        NavigationWrapperView(coordinator: navCoordinator)
            .background {
                Color
                    .base2
                    .ignoresSafeArea()
            }
            .onAppear {
                navCoordinator.path = initialPath
            }
    }
}

extension ContentView {
    var initialPath: [Factory] {
        var path: [Factory] = [
            AccessSceneFactory(
                coordinator: navCoordinator,
                injector: injector
            )
        ]
        
        if (try? injector.storage.getSession()) != nil {
            path.append(
                RoomsSceneFactory(
                    coordinator: navCoordinator,
                    injector: injector
                )
            )
        }

        return path
    }
}
