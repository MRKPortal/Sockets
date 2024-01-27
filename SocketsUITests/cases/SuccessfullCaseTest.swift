//
//  SuccessfullCaseTest.swift
//  SocketsUITests
//
//  Created by Marc Flores on 27/1/24.
//

import XCTest

final class SuccessfullCaseTest: XCTestCase {

    func testCase() throws {
        let app = XCUIApplication()
        app.launch()
        //RESET APP STATE
        try logoutIfNeeded(app: app)
        
        //SUCCESSFULLY LOGIN
        try accessTest(app: app)
    }
}

private extension SuccessfullCaseTest {
    
    func logoutIfNeeded(app: XCUIApplication) throws {
        let nameLbl = app.textFields[Identifiers.Access.nameLbl]
        let logoutBtn = app.buttons[Identifiers.Rooms.logoutBtn]
        let logoutConfirmBtn = app.buttons[Identifiers.Alerts.logoutConfirmBtn]
        
        if !logoutBtn.exists { return }
        
        //PERFORM LOGOUT
        logoutBtn.tap()
        XCTAssertTrue(logoutConfirmBtn.exists)
        logoutConfirmBtn.tap()
        XCTAssertTrue(nameLbl.exists)
    }
    
    func accessTest(app: XCUIApplication) throws {
        let btn = app.buttons[Identifiers.Access.connectBtn]
        let nameLbl = app.textFields[Identifiers.Access.nameLbl]
        let serverLbl = app.textFields[Identifiers.Access.serverLbl]
        XCTAssertFalse(btn.exists)
        XCTAssertTrue(nameLbl.exists)
        XCTAssertTrue(serverLbl.exists)

        nameLbl.tap()
        nameLbl.typeText("Maruku")
        
        serverLbl.tap()
        serverLbl.typeText("wss://socketsbay.com/wss/v2/1/demo/")
        XCUIApplication().keyboards.buttons["Return"].tap()

        XCTAssertTrue(btn.exists)
        btn.tap()
        
        let cell1 = app.otherElements[Identifiers.Rooms.roomCell(0)]
        XCTAssertTrue(cell1.waitForExistence(timeout: 1))
    }
}
