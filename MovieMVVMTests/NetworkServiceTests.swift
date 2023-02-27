// NetworkServiceTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование сетевого сервиса
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockApiKeyText = "mockApiKeyText"
        static let mockPosterPathText = "mockPosterPathText"
        static let emptyText = ""
        static let mockIdNumber = 505_642
        static let timeoutNumber = 10.0
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
        let id = Constants.mockIdNumber
        networkService?.setupAPIKey(Constants.mockApiKeyText)
        let expectation = XCTestExpectation(description: Constants.emptyText)
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
        wait(for: [expectation], timeout: Constants.timeoutNumber)
    }

    func testFetchSimilarMovies() {
        let posterPath = Constants.mockPosterPathText
        networkService?.setupAPIKey(Constants.mockApiKeyText)
        let expectation = XCTestExpectation(description: Constants.emptyText)
        networkService?.fetchSimilarMovies(idMovie: Constants.mockIdNumber, completion: { result in
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
        wait(for: [expectation], timeout: Constants.timeoutNumber)
    }
}
