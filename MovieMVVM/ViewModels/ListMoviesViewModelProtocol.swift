// ListMoviesViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью-модель экрана со списком фильмов
protocol ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol { get set }
    var networkServiceCompletion: ((Result<[Movie], Error>) -> Void)? { get set }
    var movies: [Movie] { get set }
    var movie: Movie? { get set }
    var currentCategoryMovies: CategoryMovies { get set }

    // MARK: - Public Methods

    func fetchMovies()
    func fetchData(dataCompletion: @escaping ((Result<Data, Error>) -> Void))
    func setupMovie(index: Int)
}
