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
    
    //UI test to verify that app leaves foreground when "Åben i Spotify" is tapped in currently playing screen.
    //This test will fail if no song is playing.
    func testOpenInSpotify(){
        
        let app = XCUIApplication()
        app.buttons[" Log in with Facebook "].tap()
        app.tabBars.buttons["Spiller nu"].tap()
        let state = XCUIApplication().state
        app/*@START_MENU_TOKEN@*/.buttons["Åben i Spotify"]/*[[".scrollViews.buttons[\"Åben i Spotify\"]",".buttons[\"Åben i Spotify\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.wait(for: .runningBackground, timeout: 10)
        
        XCTAssertNotEqual(XCUIApplication().state, state)
    }
}
