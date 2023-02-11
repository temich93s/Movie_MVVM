// MockCoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

@testable import MovieMVVM

/// Мок кор дата сервиса
final class MockCoreDataService: CoreDataServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPencilText = "pencil"
        static let emptyText = ""
        static let zeroNumberInt = 0
        static let zeroNumberDouble = 0.0
        static let idNumber = 0
    }

    // MARK: - Public Properties

    var movies: [Movie]?
    var isSaveSimilarMovieCorrect = false

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

    func saveSimilarMovie(id: Int, similarMovie: [SimilarMovie]) {
        if id == Constants.idNumber, similarMovie.first?.posterPath == mockSimilarMovies.first?.posterPath {
            isSaveSimilarMovieCorrect = true
        }
    }

    func getSimilarMovie(id: Int) -> [SimilarMovie]? {
        [SimilarMovie(posterPath: Constants.mockPencilText)]
    }

    func saveMovie(category: CategoryMovies, movies: [Movie]) {
        self.movies = movies
    }

    func getMovie(category: CategoryMovies) -> [Movie]? {
        mockMovies
    }
}
