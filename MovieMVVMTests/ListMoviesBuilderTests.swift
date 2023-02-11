// ListMoviesBuilderTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование сборщика модулей экрана со списоком фильмов
final class ListMoviesBuilderTests: XCTestCase {
    // MARK: - Private Properties

    var listMoviesBuilder: ListMoviesBuilder?

    // MARK: - Public Methods

    override func setUp() {
        listMoviesBuilder = ListMoviesBuilder()
    }

    override func tearDown() {
        listMoviesBuilder = nil
    }

    func testBuild() {
        let listMovies = listMoviesBuilder?.build()
        XCTAssertTrue(listMovies is ListMoviesViewController)
    }
}
