// DetailMovieViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью-модели экрана с выбранным фильмом
protocol DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol { get set }
    var similarMovies: [SimilarMovie] { get set }
    var movie: Movie { get set }
    var posterPath: String { get set }

    // MARK: - Public Methods

    func fetchData(completion: @escaping ((Result<Data, Error>) -> Void))
    func fetchPosterData(completion: @escaping ((Result<Data, Error>) -> Void))
    func fetchSimilarMovies(completion: @escaping ((Result<[SimilarMovie], Error>) -> Void))
    func setupPoster(index: Int)
}
