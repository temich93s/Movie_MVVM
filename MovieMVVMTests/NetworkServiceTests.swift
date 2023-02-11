// NetworkServiceTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование сетевого сервиса
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockApiKeyText = "8216e974d625f2a458a739c20007dcd6"
    }

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        networkService = NetworkService()
    }

    override func tearDown() {
        networkService = nil
    }

    func testFetchMovies() {
        let id = 505_642
        networkService?.setupAPIKey(Constants.mockApiKeyText)
        let expectation = XCTestExpectation(description: "")
        networkService?.fetchMovies(categoryMovies: .popular, completion: { result in
            switch result {
            case let .success(movies):
                expectation.fulfill()
                XCTAssertNotNil(movies)
                XCTAssertEqual(id, movies.first?.id)
            case let .failure(error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        })
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchSimilarMovies() {
        let posterPath = "/r12pZnSsCgLWrA4hXqdtprQ97uR.jpg"
        networkService?.setupAPIKey(Constants.mockApiKeyText)
        let expectation = XCTestExpectation(description: "")
        networkService?.fetchSimilarMovies(idMovie: 315_162, completion: { result in
            switch result {
            case let .success(similarMovies):
                expectation.fulfill()
                XCTAssertNotNil(similarMovies)
                XCTAssertEqual(posterPath, similarMovies.first?.posterPath)
            case let .failure(error):
                expectation.fulfill()
                XCTAssertNotNil(error)
            }
        })
        wait(for: [expectation], timeout: 10.0)
    }
}
