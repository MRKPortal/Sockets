//
//  RoomsScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

protocol RoomsScenePresenterProtocol: ObservableObject {
    var rooms: [RoomModel] { get }
}

final class RoomsScenePresenter: RoomsScenePresenterProtocol {
    @Published var rooms: [RoomModel] = [.init(name: "Room 1", key: "---")]
}
