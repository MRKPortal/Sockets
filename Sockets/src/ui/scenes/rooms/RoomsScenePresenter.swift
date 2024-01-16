//
//  RoomsScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

protocol RoomsScenePresenterProtocol: ObservableObject {
    var rooms: [RoomModel] { get }
    
    func didTapAdd()
    func didTap(room: RoomModel)
}

final class RoomsScenePresenter: RoomsScenePresenterProtocol {
    
    private let router: RoomsSceneRouterProtocol
    
    @Published var rooms: [RoomModel] = [.init(name: "Lokitas", key: "---")]
    
    init(router: RoomsSceneRouterProtocol) {
        self.router = router
    }
    
    func didTapAdd() {
        rooms.append(.init(name: "Lokitas", key: "---"))
    }
    
    func didTap(room: RoomModel) {
        router.openChat(
            room: room
        )
    }
}
