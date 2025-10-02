//
//  BifocalUITests.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 01/10/2025.
//

import Foundation
import XCTest

final class BifocalUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testCreateNewSkillFlow() throws {
        // 1. Launch the application
        let app = XCUIApplication()
        app.launch()

        let copeAheadTabButton = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(copeAheadTabButton.waitForExistence(timeout: 5), "The 'Cope-Ahead' tab bar button should exist.")
        copeAheadTabButton.tap()

        let newCopeAheadButton = app.buttons["New Cope-Ahead"]
        XCTAssertTrue(newCopeAheadButton.waitForExistence(timeout: 5), "The 'New Cope-Ahead' button should exist.")
        newCopeAheadButton.tap()
    }
}
