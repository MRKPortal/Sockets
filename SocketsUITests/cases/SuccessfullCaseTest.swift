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
        
        let roomKey = UUID().uuidString
        
        //RESET APP STATE
        logoutIfNeeded(app: app)
        
        //SUCCESSFULLY LOGIN
        accessTest(app: app)
        
        //CREATE ROOM
        createRoomTest(app: app, name: "Class 7", key: roomKey)
        
        //COPY KEY
        copyPrivateKey(app: app, key: roomKey)
        
        //SEND MESSAGE
        sendMessage(app: app, message: "Hello there!")

        //RESET APP STATE
        logoutIfNeeded(app: app)
    }
}

private extension SuccessfullCaseTest {

    func logoutIfNeeded(app: XCUIApplication) {
        let backButton = app.buttons[Identifiers.Chat.backBtn]
        if backButton.exists {
            //LEAVE CHAT SCENE
            backButton.tap()
        }
        
        let logoutBtn = app.buttons[Identifiers.Rooms.logoutBtn]
        
        if logoutBtn.exists {
            //LOGOUT
            logoutBtn.tap()
            let logoutConfirmBtn = app.buttons[Identifiers.Alerts.logoutConfirmBtn]
            XCTAssertTrue(logoutConfirmBtn.exists)
            logoutConfirmBtn.tap()
        }
        
        let nameLbl = app.textFields[Identifiers.Access.nameTF]
        XCTAssertTrue(nameLbl.exists)
    }
    
    func accessTest(app: XCUIApplication) {
        let btn = app.buttons[Identifiers.Access.connectBtn]
        let nameLbl = app.textFields[Identifiers.Access.nameTF]
        let serverLbl = app.textFields[Identifiers.Access.serverTF]
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
    
    func createRoomTest(app: XCUIApplication, name: String, key: String) {
        let addBtn = app.buttons[Identifiers.Rooms.addBtn]
        XCTAssertTrue(addBtn.exists)
        addBtn.tap()
        
        let nameLbl = app.textFields[Identifiers.Alerts.createRoomNameTF]
        let keyLbl = app.textFields[Identifiers.Alerts.createRoomKeyTF]
        let btn = app.buttons[Identifiers.Alerts.createRoomBtn]

        XCTAssertTrue(nameLbl.exists)
        XCTAssertTrue(keyLbl.exists)
        XCTAssertTrue(btn.exists)
        XCTAssertFalse(btn.isEnabled)
        
        nameLbl.tap()
        nameLbl.typeText(name)
        keyLbl.tap()
        keyLbl.typeText(key)
        XCTAssertTrue(btn.isEnabled)
        XCUIApplication().keyboards.buttons["Return"].tap()
        btn.tap()

        let cell = app.staticTexts[Identifiers.Rooms.roomCell(0)]
        XCTAssertEqual(cell.label, name)
        cell.forceTap()

        let input = app.textFields[Identifiers.Chat.inputTF]
        XCTAssertTrue(input.exists)
        
        let title = app.staticTexts[Identifiers.Chat.titleLbl]
        XCTAssertEqual(title.label, name)
    }
    
    func copyPrivateKey(app: XCUIApplication, key: String) {
        let title = app.staticTexts[Identifiers.Chat.titleLbl]
        XCTAssertTrue(title.exists)
        title.press(forDuration: 1)
        
        let toast = app.staticTexts[Identifiers.Alerts.toastLbl]
        XCTAssertTrue(toast.waitForExistence(timeout: 1))
        XCTAssertEqual(toast.label, Ls.chatFeedbackKeyCopied)
        XCTAssertEqual(UIPasteboard.general.string, key)
    }
    
    func sendMessage(app: XCUIApplication, message: String) {
        let sendBtn = app.buttons[Identifiers.Chat.sendBtn]
        let inputTF = app.textFields[Identifiers.Chat.inputTF]
        XCTAssertTrue(inputTF.exists)
        XCTAssertTrue(sendBtn.exists)
        XCTAssertFalse(sendBtn.isEnabled)
        
        inputTF.tap()
        inputTF.typeText(message)
        XCTAssertTrue(sendBtn.isEnabled)
        
        XCUIApplication().keyboards.buttons["Return"].tap()

        sendBtn.tap()
        XCTAssertEqual(inputTF.label, "")
        
        let messateLbl = app.staticTexts[Identifiers.Chat.messageContentLbl]
        XCTAssertEqual(messateLbl.label, message)
    }
}
