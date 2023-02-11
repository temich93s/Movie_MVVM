// DetailMovieBuilderTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование сборщика модулей экрана со списоком фильмов
final class DetailMovieBuilderTests: XCTestCase {
    // MARK: - Private Properties

    private let mockMovie = Movie(
        id: 0,
        overview: "",
        posterPath: "pencil",
        releaseDate: "",
        title: "",
        voteAverage: 0,
        voteCount: 0
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
