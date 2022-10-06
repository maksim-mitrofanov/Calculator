//
//  Calculator_UITests.swift
//  Calculator_UITests
//
//  Created by Максим Митрофанов on 06.10.2022.
//

import XCTest

final class Calculator_UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["+"].tap()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["-"].tap()
        app.buttons["3"].tap()
        app.buttons["2"].tap()
        app.buttons["6"].tap()
        app.buttons["x"].tap()
        app.buttons["0"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
                
        
    }
}
