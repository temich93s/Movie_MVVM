// MovieMVVMUITestsLaunchTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

final class MovieMVVMUITestsLaunchTests: XCTestCase {
    // MARK: - Constants

    private enum Constants {
        static let launchScreenText = "Launch Screen"
    }

    // MARK: - Public Methods

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = Constants.launchScreenText
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
