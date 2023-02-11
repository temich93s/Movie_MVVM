// MockCoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

@testable import MovieMVVM

/// Мок кор дата сервиса
final class MockCoreDataService: CoreDataServiceProtocol {
    // MARK: - Public Properties

    var movies: [Movie]?
    var isSaveSimilarMovieCorrect = false

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

    func saveSimilarMovie(id: Int, similarMovie: [SimilarMovie]) {
        if id == 0, similarMovie.first?.posterPath == mockSimilarMovies.first?.posterPath {
            isSaveSimilarMovieCorrect = true
        }
    }

    func getSimilarMovie(id: Int) -> [SimilarMovie]? {
        [SimilarMovie(posterPath: "pencil")]
    }

    func saveMovie(category: CategoryMovies, movies: [Movie]) {
        self.movies = movies
    }

    func getMovie(category: CategoryMovies) -> [Movie]? {
        mockMovies
    }
}
