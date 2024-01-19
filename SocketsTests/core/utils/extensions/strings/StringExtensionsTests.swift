//
//  StringExtensionsTests.swift
//  SocketsTests
//
//  Created by Marc Flores on 13/1/24.
//

import XCTest

final class StringExtensionsTests: XCTestCase {
    func testNumber() {
        XCTAssertEqual("a".number, 97)
        XCTAssertEqual("aa".number, 194)
        XCTAssertEqual("b".number, 98)
        XCTAssertEqual("bb".number, 196)
        XCTAssertEqual("ab".number, 195)
        XCTAssertEqual("ab".number, "ba".number)
    }
}
