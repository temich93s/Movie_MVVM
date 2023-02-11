// DetailMovieViewModelTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование вью-модели экрана со списоком фильмов
final class DetailMovieViewModelTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockValue = "mock"
    }

    // MARK: - Private Properties

    private let mockNetworkService = MockNetworkService()
    private let mockImageService = MockImageService()
    private let mockKeychainService = MockKeychainService()
    private let mockCoreDataService = MockCoreDataService()
    private let mockSimilarMovies = [SimilarMovie(posterPath: "pencil")]
    private let mockMovie = Movie(
        id: 0,
        overview: "",
        posterPath: "pencil",
        releaseDate: "",
        title: "",
        voteAverage: 0,
        voteCount: 0
    )

    private var detailMovieViewModel: DetailMovieViewModel?

    // MARK: - Public Methods

    override func setUp() {
        detailMovieViewModel = DetailMovieViewModel(
            networkService: mockNetworkService,
            imageService: mockImageService,
            keychainService: mockKeychainService,
            coreDataService: mockCoreDataService,
            movie: mockMovie
        )
    }

    override func tearDown() {
        detailMovieViewModel = nil
    }

    func testFetchMainPosterData() {
        detailMovieViewModel?.movie = mockMovie
        detailMovieViewModel?.mainPosterCompletion = { result in
            switch result {
            case let .success(mockData):
                let data = Data(count: 8)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
        detailMovieViewModel?.fetchMainPosterData()
    }

    func testSimilarPoster() {
        let mockCompletion: ((Result<Data, Error>) -> Void)? = { result in
            switch result {
            case let .success(mockData):
                let data = Data(count: 8)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
        detailMovieViewModel?.posterPath = "pencil"
        detailMovieViewModel?.setupSimilarPosterCompetion(completion: mockCompletion)
        detailMovieViewModel?.fetchSimilarPosterData()
    }

    func testFetchSimilarMovies() {
        detailMovieViewModel?.movie = mockMovie
        detailMovieViewModel?.similarMoviesCompletion = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(similarMovies):
                XCTAssertEqual(self.mockSimilarMovies.first?.posterPath, similarMovies.first?.posterPath)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
        detailMovieViewModel?.fetchSimilarMovies()
        XCTAssertEqual(mockSimilarMovies.first?.posterPath, detailMovieViewModel?.similarMovies.first?.posterPath)
    }

    func testSetupPoster() {
        detailMovieViewModel?.similarMovies = mockSimilarMovies
        detailMovieViewModel?.setupPoster(index: 0)
        XCTAssertEqual(mockSimilarMovies.first?.posterPath, mockSimilarMovies.first?.posterPath)
    }

    func testUploadApiKey() {
        detailMovieViewModel?.uploadApiKey(Constants.mockValue)
        XCTAssertNotNil(mockKeychainService.keyValue)
        guard let apiKey = mockKeychainService.keyValue else { return }
        XCTAssertEqual(Constants.mockValue, apiKey)
    }

    func testCheckApiKey() {
        detailMovieViewModel?.checkApiKey()
        XCTAssertNotNil(mockNetworkService.apiKey)
        guard let apiKey = mockNetworkService.apiKey else { return }
        XCTAssertEqual(Constants.mockValue, apiKey)
    }
}
