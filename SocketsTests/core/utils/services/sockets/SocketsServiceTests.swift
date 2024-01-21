//
//  SocketsServiceTests.swift
//  SocketsTests
//
//  Created by Marc Flores on 21/1/24.
//

import XCTest
import Combine

@testable import Sockets

final class SocketsServiceTests: XCTestCase {

    private var cancellable: AnyCancellable?
    
    func testConnectingState() {
        let sockets = SocketsService()
        sockets.connect(url: "wss://socketsbay.com/wss/v2/1/demo/")
        let exp = expectation(description: "Base state connecting")
        cancellable = sockets.connectionPublisher.sink { state in
            if case .connecting = state {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }

    func testWrongConnectingState() {
        let sockets = SocketsService()
        sockets.connect(url: "http://notaserver.com")
        let exp = expectation(description: "Wrong server connecting")
        cancellable = sockets.connectionPublisher.sink { state in
            if case .disconnected = state {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 1)
    }

    func testCorrectConnectingState() {
        let sockets = SocketsService()
        sockets.connect(url: "wss://ws.postman-echo.com/raw")
        let exp = expectation(description: "Successfully connected")
        cancellable = sockets.connectionPublisher.sink { state in
            if case .connected = state {
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 15)
    }
}
