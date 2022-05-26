//
//  GitHubRepositoriesUITests.swift
//  GitHubRepositoriesUITests
//
//  Created by Todor Dimitrov on 26.05.22.
//

import XCTest

class GitHubRepositoriesUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        XCUIApplication().launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testSignIn() throws {
        doSignIn()
        
        sleep(1)
        XCTAssertTrue(XCUIApplication().navigationBars["Dashboard"].staticTexts["Dashboard"].exists)
        
    }
    
    func testSignOut() throws {
        doSignIn()
        sleep(1)
        XCUIApplication().buttons["Reply"].tap()
        XCTAssertTrue(XCUIApplication().staticTexts["GitHubRepositories"].exists)
                
    }
    
    func testLastRefereshLabel() throws {
        doSignIn()
        sleep(1)
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts["Last refreshed: a moment ago"].exists)
        sleep(60)
        XCTAssertTrue(app.staticTexts["Last refreshed: a minute ago"].exists)
                
    }
}

//MARK: Helpers
extension GitHubRepositoriesUITests {
    func doSignIn() {
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts["GitHubRepositories"].exists)
        
        let enterYourUsernameTextField = app.textFields["Enter your username"]
        enterYourUsernameTextField.tap()
        enterYourUsernameTextField.typeText("oppsx7")
        app/*@START_MENU_TOKEN@*/.staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
