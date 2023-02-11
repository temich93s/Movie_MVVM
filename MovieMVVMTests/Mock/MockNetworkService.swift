// MockNetworkService.swift
// Copyright © SolovevAA. All rights reserved.

@testable import MovieMVVM
import UIKit

// Мок сетевого сервиса
final class MockNetworkService: NetworkServiceProtocol {
    // MARK: - Public Properties

    var apiKey: String?

    // MARK: - Private Properties

    private let mockMovies = [Movie(
        id: 0,
        overview: "",
        posterPath: "pencil",
        releaseDate: "",
        title: "",
        voteAverage: 0,
        voteCount: 0
    )]
    private let mockSimilarMovies = [SimilarMovie(posterPath: "pencil")]

    // MARK: - Public Methods

    func fetchMovies(
        categoryMovies: CategoryMovies,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        completion(.success(mockMovies))
    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void)) {
        if idMovie == 0 {
            completion(.success(mockSimilarMovies))
        }
    }

    func setupAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
}
