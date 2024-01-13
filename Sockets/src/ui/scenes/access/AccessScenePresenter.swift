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

    @Published var url: String = ""
    @Published var username: String = ""
    
    init(interactor: AccessSceneInteractorProtocol) {
        
    }
    
    func connect() {
        
    }
}
