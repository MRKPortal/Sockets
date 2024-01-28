//
//  Element+ForceTap.swift
//  SocketsUITests
//
//  Created by Marc Flores on 28/1/24.
//

import XCTest

extension XCUIElement {
    func forceTap() {
        coordinate(withNormalizedOffset: .zero).tap()
    }
}
