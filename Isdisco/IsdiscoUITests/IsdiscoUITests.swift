//
//  IsdiscoUITests.swift
//  IsdiscoUITests
//
//  Created by Thomas Mattsson on 13/05/2019.
//  Copyright © 2019 Rasmus Gregersen. All rights reserved.
//

import XCTest

class IsdiscoUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.buttons[" Log in with Facebook "].tap()
        app.tabBars.buttons["Feedback"].tap()
        app.buttons["Send feedback"].tap()
        
    }
    
    //UI test to see if the select user ID button on the login screen works.
    func testIdLogIn() {
        let app = XCUIApplication()
        app.steppers.buttons["Increment"].tap()
        //app.buttons[" Log in with Facebook "].tap()
        let userIdLabel = XCUIApplication().staticTexts["userIDLabel"].label
        XCTAssertEqual("ID: 2", userIdLabel)
    }
    
    func testUpvoteButton
    
}
