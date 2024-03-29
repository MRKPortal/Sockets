//
//  RoomsScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 15/1/24.
//

import SwiftUI

protocol RoomsScenePresenterProtocol: ObservableObject {
    var rooms: [RoomModel] { get }
    var server: String { get }
    var feedbackPublisher: FeedbackPublisher { get }
    var connectionPublisher: ConnectionPublisher { get }

    func connect()
    func didTapAdd()
    func didTap(room: RoomModel)
    func didTapLogout()
}

final class RoomsScenePresenter: RoomsScenePresenterProtocol {
    
    private let router: RoomsSceneRouterProtocol
    private let feedback: FeedbackSystemProtocol
    private let interactor: RoomsSceneInteractorProtocol

    var feedbackPublisher: FeedbackPublisher {
        feedback.feedbackPublisher
    }
    
    var server: String {
        (try? interactor.getSession())?.url ?? ""
    }
    
    var connectionPublisher: ConnectionPublisher {
        interactor.connectionPublisher
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    @Published var rooms: [RoomModel] = []
    
    init(interactor: RoomsSceneInteractorProtocol, router: RoomsSceneRouterProtocol, feedback: FeedbackSystemProtocol) {
        self.interactor = interactor
        self.router = router
        self.feedback = feedback

        rooms = (try? interactor.getRooms()) ?? []
    }
    
    func connect() {
        try? interactor.connect()
    }
    
    func didTapAdd() {
        feedback.display(
            feedback: .alert(
                .createRoom(createRoom)
            )
        )
    }
    
    func didTap(room: RoomModel) {
        router.openChat(
            room: room
        )
    }
    
    func didTapLogout() {
        feedback.display(
            feedback: .alert(
                .logOut(logout)
            )
        )
    }
}

private extension RoomsScenePresenter {
    
    func logout() {
        interactor.logout()
        router.pop()
    }
    
    func createRoom(name: String, key: String) {
        do {
            try interactor.addRoom(name: name, password: key)
            rooms = try interactor.getRooms()
        } catch {
            //
        }
    }
}
