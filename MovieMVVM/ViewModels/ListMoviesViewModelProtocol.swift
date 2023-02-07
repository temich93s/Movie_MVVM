// ListMoviesViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью-модель экрана со списком фильмов
protocol ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol { get set }
    var imageService: LoadImageProtocol { get set }
    var movies: [Movie] { get set }
    var movie: Movie? { get set }
    var currentCategoryMovies: CategoryMovies { get set }
    var listMoviesState: ((ListMoviesState) -> ())? { get set }

    // MARK: - Public Methods

    func fetchMovies()
    func fetchData(completion: @escaping ((Result<Data, Error>) -> Void))
    func setupMovie(index: Int)
    func makeRefresh()
    func setupCategory(tag: Int)
}
