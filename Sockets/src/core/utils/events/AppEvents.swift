//
//  AppEvents.swift
//  Sockets
//
//  Created by Marc Flores on 12/1/24.
//

import Combine
import UIKit

struct AppEvents {
    
    static let main = AppEvents()
    
    //Events Publishers
    let appBecameActive: AnyPublisher<Notification, Never>
    let appWillTerminate: AnyPublisher<Notification, Never>
    let keyBoardWillShow: AnyPublisher<CGFloat, Never>
    let keyBoardWillHide: AnyPublisher<CGFloat, Never>
    
    
    private init() {
        let center = NotificationCenter.default
        appBecameActive = center.publisher(for: UIApplication.didBecomeActiveNotification).eraseToAnyPublisher()
        appWillTerminate = center.publisher(for: UIApplication.willTerminateNotification).eraseToAnyPublisher()
        keyBoardWillShow = center.publisher(for: UIApplication.keyboardWillShowNotification)
            .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
            .eraseToAnyPublisher()
        keyBoardWillHide = center.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in 0 }
            .eraseToAnyPublisher()
    }
}
