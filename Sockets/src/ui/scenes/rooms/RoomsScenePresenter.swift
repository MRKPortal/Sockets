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
    private let interactor: RoomsSceneInteractorProtocol

    var feedbackPublisher: FeedbackPublisher {
        feedback.feedbackPublisher
    }
    
    @Published var rooms: [RoomModel] = []
    
    init(interactor: RoomsSceneInteractorProtocol, router: RoomsSceneRouterProtocol, feedback: FeedbackSystemProtocol) {
        self.interactor = interactor
        self.router = router
        self.feedback = feedback

        rooms = (try? interactor.getRooms()) ?? []
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
        do {
            try interactor.addRoom(name: name, key: key)
            rooms = try interactor.getRooms()
        } catch {
            //
        }
    }
}
