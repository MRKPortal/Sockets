//
//  RoomsScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

protocol RoomsScenePresenterProtocol: ObservableObject {
    var rooms: [RoomModel] { get }
    var feedbackPublisher: FeedbackPublisher { get }
    func didTapAdd()
    func didTap(room: RoomModel)
}

final class RoomsScenePresenter: RoomsScenePresenterProtocol {
    
    private let router: RoomsSceneRouterProtocol
    private let feedback: FeedbackSystemProtocol
    
    var feedbackPublisher: FeedbackPublisher {
        feedback.feedbackPublisher
    }
    
    @Published var rooms: [RoomModel] = [.init(name: "Lokitas", key: "---")]
    
    init(router: RoomsSceneRouterProtocol, feedback: FeedbackSystemProtocol) {
        self.router = router
        self.feedback = feedback
    }
    
    func didTapAdd() {
        feedback.display(feedback: 
                .alert(
                    .createRoom(createRoom)
                )
        )
    }
    
    func didTap(room: RoomModel) {
        router.openChat(
            room: room
        )
    }
}

private extension RoomsScenePresenter {
    func createRoom(name: String, key: String) {
        rooms.append(.init(name: name, key: key))
    }
}
