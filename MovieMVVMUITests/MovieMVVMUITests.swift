// MovieMVVMUITests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

final class MovieMVVMUITests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let topRatedCategoryName = "Top Rated"
        static let topUpComingName = "Up Coming"
        static let topPopularName = "Popular"
        static let identifierCatalogTableView = "MovieListTableView"
        static let overviewText = "Overview"
        static let moviesText = "Movies"
    }

    // MARK: - Private Properties

    private let app = XCUIApplication()

    // MARK: - Public Methods

    override func setUp() {
        app.launch()
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testMovieMVP() {
        tapCell()
        app.buttons[Constants.topRatedCategoryName].tap()
        tapCell()
        app.buttons[Constants.topUpComingName].tap()
        tapCell()
        app.buttons[Constants.topPopularName].tap()
    }

    // MARK: - Private Methods

    private func tapCell() {
        let tableView = app.tables.matching(identifier: Constants.identifierCatalogTableView)
        XCTAssertNotNil(tableView)
        tableView.element.swipeUp()
        tableView.element.swipeDown()
        app.cells.firstMatch.tap()
        app.swipeUp()
        app.swipeDown()
        app.navigationBars[Constants.overviewText].buttons[Constants.moviesText].tap()
    }
}
