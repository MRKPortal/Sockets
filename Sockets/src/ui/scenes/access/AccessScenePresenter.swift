//
//  AccessScenePresenter.swift
//  Sockets
//
//  Created by Marc Flores on 13/1/24.
//

import Foundation
import SwiftUI

protocol AccessScenePresenterProtocol: ObservableObject {
    var url: String { get set }
    var username: String { get set }
    func connect()
}

final class AccessScenePresenter: AccessScenePresenterProtocol {

    private let interactor: AccessSceneInteractorProtocol
    
    @Published var url: String = ""
    @Published var username: String = ""
    
    init(interactor: AccessSceneInteractorProtocol) {
        self.interactor = interactor
    }
    
    func connect() {
        do {
            try interactor.configureSession(username: username, url: url)
        } catch {
            print(error)
        }
    }
}
