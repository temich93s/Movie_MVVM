// DetailMovieViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью-модели экрана с выбранным фильмом
protocol DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var similarMovies: [SimilarMovie] { get set }
    var movie: Movie { get set }
    var posterPath: String { get set }
    var similarMoviesCompletion: ((Result<[SimilarMovie], Error>) -> Void)? { get set }
    var similarPosterCompletion: ((Result<Data, Error>) -> Void)? { get set }
    var mainPosterCompletion: ((Result<Data, Error>) -> Void)? { get set }
    var uploadApiKeyHandler: VoidHandler? { get set }
    var reloadHandler: VoidHandler? { get set }

    // MARK: - Public Methods

    func fetchMainPosterData()
    func fetchSimilarPosterData()
    func setupSimilarPosterCompetion(completion: ((Result<Data, Error>) -> Void)?)
    func fetchSimilarMovies()
    func setupPoster(index: Int)
    func uploadApiKey(_ key: String)
    func checkApiKey()
}
