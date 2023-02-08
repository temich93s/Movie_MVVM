// ListMoviesViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью-модель экрана со списком фильмов
protocol ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var currentCategoryMovies: CategoryMovies { get set }
    var listMoviesState: ((ListMoviesState<Movie>) -> ())? { get set }
    var uploadApiKeyCompletion: (() -> ())? { get set }

    // MARK: - Public Methods

    func fetchMovies()
    func fetchData(movie: Movie, completion: @escaping ((Result<Data, Error>) -> Void))
    func setupCategory(tag: Int)
    func uploadApiKey(_ key: String)
    func checkApiKey()
}
