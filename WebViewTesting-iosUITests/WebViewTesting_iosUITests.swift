//
//  WebViewTesting_iosUITests.swift
//  WebViewTesting-iosUITests
//
//  Created by Oren Zakay on 13/09/2020.
//  Copyright © 2020 Oren Zakay. All rights reserved.
//

import XCTest

class WebViewTesting_iosUITests: XCTestCase {

    let app: XCUIApplication = XCUIApplication()
    lazy var webview: XCUIElement = app.webViews.element(boundBy: 0)
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testPrintWebViewHie() {
        debugPrint(webview)
    }
    
    func testDiv() {
        XCTAssertTrue(webview.otherElements["divdiv1"].exists)
    }

    func testInsideDeepHierarchy() {
        XCTAssertTrue(webview.staticTexts["testingh1-2"].exists)
    }
    
    func testSetInuputAndChangeText() {
        let TEXT = "This is the new text"
        let textInput = webview.textFields["textInput"]
        textInput.tap()
        textInput.typeText("")
        textInput.typeText(TEXT)
        webview.buttons["changeTextBtn"].tap()
        XCTAssertTrue(webview.staticTexts[TEXT].waitForExistence(timeout: 250))
    }

    func testScrollToView() {
        let textInput2 = webview.textFields["textInput2"]
        webview.scrollToElement(element: textInput2)
        XCTAssertTrue(textInput2.isHittable)
    }
}

extension XCTestCase {
  func wait(for duration: TimeInterval) {
    let waitExpectation = expectation(description: "Waiting")
    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
      waitExpectation.fulfill()
    }
    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }
  /// Wait for element to appear
  func wait(for element: XCUIElement, timeout duration: TimeInterval) {
    let predicate = NSPredicate(format: "exists == true")
    let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)
    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }
}

extension XCUIElement {

    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }

}
