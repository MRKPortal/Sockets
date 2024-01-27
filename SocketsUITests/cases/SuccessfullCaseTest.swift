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
        logoutIfNeeded(app: app)
        
        //SUCCESSFULLY LOGIN
        accessTest(app: app)
        
        //CREATE ROOM
        createRoomTest(app: app, name: "Class 7")
    }
}

private extension SuccessfullCaseTest {
    
    func logoutIfNeeded(app: XCUIApplication) {
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
    
    func accessTest(app: XCUIApplication) {
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
    
    func createRoomTest(app: XCUIApplication, name: String) {
        let addBtn = app.buttons[Identifiers.Rooms.addBtn]
        XCTAssertTrue(addBtn.exists)
        addBtn.tap()
        
        let nameLbl = app.textFields[Identifiers.Alerts.createRoomNameLbl]
        let keyLbl = app.textFields[Identifiers.Alerts.createRoomKeyLbl]
        let btn = app.buttons[Identifiers.Alerts.createRoomBtn]

        XCTAssertTrue(nameLbl.exists)
        XCTAssertTrue(keyLbl.exists)
        XCTAssertTrue(btn.exists)
        XCTAssertFalse(btn.isEnabled)
        
        nameLbl.tap()
        nameLbl.typeText(name)
        keyLbl.tap()
        keyLbl.typeText(UUID().uuidString)
        XCTAssertTrue(btn.isEnabled)
        XCUIApplication().keyboards.buttons["Return"].tap()
        btn.tap()
        
        let cell = app.staticTexts[Identifiers.Rooms.roomCell(0)]
        XCTAssertEqual(cell.label, name)
    }
}
