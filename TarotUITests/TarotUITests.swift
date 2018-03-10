//
//  TarotUITests.swift
//  TarotUITests
//
//  Created by Rodney Cocker on 10/3/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import XCTest

class TarotUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample()
    {
        // Get a reference to your app
        let app = XCUIApplication()
        
        // Test that the initial label text is what you expect
        var string = app.staticTexts.element(matching: .any, identifier: "answer").label
        XCTAssertEqual(string, "Think of a question")
        
        // Test that there is only 1 image displayed on the view
        XCTAssertEqual(app.images.count, 1)
        
        // Test that there is only 1 button on the view
        XCTAssertEqual(app.buttons.count, 1)
        
        // Tap the button
        app.buttons["Ask the oracle"].tap()
        
        // Test that the label has changed as a result of tapping the button '
        string = app.staticTexts.element(matching: .any, identifier: "answer").label
        XCTAssertNotEqual(string,  "Think of a question")
    }
    
}
