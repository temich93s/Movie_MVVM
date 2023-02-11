// DetailMovieBuilderTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование сборщика модулей экрана со списоком фильмов
final class DetailMovieBuilderTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPencilText = "pencil"
        static let emptyText = ""
        static let zeroNumberInt = 0
        static let zeroNumberDouble = 0.0
    }

    // MARK: - Private Properties

    private let mockMovie = Movie(
        id: Constants.zeroNumberInt,
        overview: Constants.emptyText,
        posterPath: Constants.mockPencilText,
        releaseDate: Constants.emptyText,
        title: Constants.emptyText,
        voteAverage: Constants.zeroNumberDouble,
        voteCount: Constants.zeroNumberDouble
    )

    var detailMovieBuilder: DetailMovieBuilder?

    // MARK: - Public Methods

    override func setUp() {
        detailMovieBuilder = DetailMovieBuilder()
    }

    override func tearDown() {
        detailMovieBuilder = nil
    }

    func testBuild() {
        let detailMovie = detailMovieBuilder?.build(movie: mockMovie)
        XCTAssertTrue(detailMovie is DetailMovieViewController)
    }
}
