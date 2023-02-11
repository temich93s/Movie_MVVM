// MockNetworkService.swift
// Copyright © SolovevAA. All rights reserved.

@testable import MovieMVVM
import UIKit

// Мок сетевого сервиса
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPencilText = "pencil"
        static let emptyText = ""
        static let zeroNumberInt = 0
        static let zeroNumberDouble = 0.0
        static let idNumber = 0
    }

    // MARK: - Public Properties

    var apiKey: String?

    // MARK: - Private Properties

    private let mockMovies = [Movie(
        id: Constants.zeroNumberInt,
        overview: Constants.emptyText,
        posterPath: Constants.mockPencilText,
        releaseDate: Constants.emptyText,
        title: Constants.emptyText,
        voteAverage: Constants.zeroNumberDouble,
        voteCount: Constants.zeroNumberDouble
    )]
    private let mockSimilarMovies = [SimilarMovie(posterPath: Constants.mockPencilText)]

    // MARK: - Public Methods

    func fetchMovies(
        categoryMovies: CategoryMovies,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        completion(.success(mockMovies))
    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void)) {
        if idMovie == Constants.idNumber {
            completion(.success(mockSimilarMovies))
        }
    }

    func setupAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
}
