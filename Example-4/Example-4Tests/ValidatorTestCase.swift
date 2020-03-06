//
//  ValidatorTestCase.swift
//  Example-4Tests
//
//  Created by Sergey Ryazanov on 06.03.2020.
//  Copyright © 2020 home. All rights reserved.
//

import XCTest
@testable import Example_4

class ValidatorTestCase: XCTestCase {
    var validator: Validator!

    override func setUp() {
        super.setUp()
        validator = Validator()
    }

    override func tearDown() {
        validator = nil
        super.tearDown()
    }

    func testValidator() {
        let tests: [String] = [
            "username",
            "1username"
        ]

        for test in tests {
            XCTAssertTrue(validator.validate(test), "Login failed: \(test)")
        }
    }

    func testLongString() {
        let input = "i" + String(repeating: "1", count: 32)
        XCTAssertTrue(validator.validate(input), "Failed with \(input.count) characters")
    }

    func testShortString() {
        let input = "ii"
        XCTAssertTrue(validator.validate(input), "Failed with \(input.count) characters")
    }

    func testSimpleName() {
        let userName = "username.-1"
        XCTAssertTrue(validator.validate(userName), "Failed with username \(userName)")
    }

    func testCorrectEmail() {
        let email = "user@gmail.com"
        XCTAssertTrue(validator.validate(email), "Failed with email \(email)")
    }

}
