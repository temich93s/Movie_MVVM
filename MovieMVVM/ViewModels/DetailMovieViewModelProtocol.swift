// DetailMovieViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью-модели экрана с выбранным фильмом
protocol DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol { get set }
    var dataCompletion: ((Result<Data, Error>) -> Void)? { get set }
    var similarMovieCompletion: ((Result<[SimilarMovie], Error>) -> Void)? { get set }
    var similarMovies: [SimilarMovie] { get set }
    var movie: Movie { get set }
    var posterPath: String { get set }

    // MARK: - Public Methods

    func fetchData()
    func fetchPosterData(dataPosterCompletion: @escaping ((Result<Data, Error>) -> Void))
    func fetchSimilarMovies()
    func setupPoster(index: Int)
}
