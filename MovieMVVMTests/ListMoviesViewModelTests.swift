// ListMoviesViewModelTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование вью-модели экрана со списоком фильмов
final class ListMoviesViewModelTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockValue = "mock"
    }

    // MARK: - Private Properties

    private let mockNetworkService = MockNetworkService()
    private let mockImageService = MockImageService()
    private let mockKeychainService = MockKeychainService()
    private let mockCoreDataService = MockCoreDataService()
    private let mockMovies = [Movie(
        id: 0,
        overview: "",
        posterPath: "pencil",
        releaseDate: "",
        title: "",
        voteAverage: 0,
        voteCount: 0
    )]
    private let mockMovie = Movie(
        id: 0,
        overview: "",
        posterPath: "pencil",
        releaseDate: "",
        title: "",
        voteAverage: 0,
        voteCount: 0
    )

    private var listMoviesViewModel: ListMoviesViewModelProtocol?
    private var mockProps: ListMoviesState<Movie>?

    // MARK: - Public Methods

    override func setUp() {
        listMoviesViewModel = ListMoviesViewModel(
            networkService: mockNetworkService,
            imageService: mockImageService,
            keychainService: mockKeychainService,
            coreDataService: mockCoreDataService
        )
    }

    override func tearDown() {
        listMoviesViewModel = nil
        mockProps = nil
    }

    func testFetchMovies() {
        var loading = false
        listMoviesViewModel?.listMoviesState = { [weak self] states in
            guard let self = self else { return }
            switch states {
            case .initial:
                XCTAssertTrue(false)
            case .loading:
                loading = true
            case let .success(movies):
                XCTAssertEqual(movies.first?.id, self.mockMovies.first?.id)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
        listMoviesViewModel?.fetchMovies()
        XCTAssertTrue(loading)
        XCTAssertNotNil(mockCoreDataService.movies)
        guard let movies = mockCoreDataService.movies else { return }
        XCTAssertEqual(movies.first?.id, mockMovies.first?.id)
    }

    func testFetchData() {
        listMoviesViewModel?.fetchData(movie: mockMovie, completion: { result in
            switch result {
            case let .success(mockData):
                let data = Data(count: 8)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }

    func testSetupCategory() {
        listMoviesViewModel?.setupCategory(tag: 0)
        XCTAssertEqual(listMoviesViewModel?.currentCategoryMovies, .popular)
        listMoviesViewModel?.setupCategory(tag: 1)
        XCTAssertEqual(listMoviesViewModel?.currentCategoryMovies, .topRated)
        listMoviesViewModel?.setupCategory(tag: 2)
        XCTAssertEqual(listMoviesViewModel?.currentCategoryMovies, .upcoming)
    }

    func testUploadApiKey() {
        listMoviesViewModel?.uploadApiKey(Constants.mockValue)
        XCTAssertNotNil(mockKeychainService.keyValue)
        guard let apiKey = mockKeychainService.keyValue else { return }
        XCTAssertEqual(Constants.mockValue, apiKey)
        XCTAssertNotNil(mockNetworkService.apiKey)
        guard let apiKey = mockNetworkService.apiKey else { return }
        XCTAssertEqual(Constants.mockValue, apiKey)
    }

    func testCheckApiKey() {
        listMoviesViewModel?.checkApiKey()
        XCTAssertNotNil(mockNetworkService.apiKey)
        guard let apiKey = mockNetworkService.apiKey else { return }
        XCTAssertEqual(Constants.mockValue, apiKey)
    }
}
