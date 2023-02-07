// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана с выбранным фильмом
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol
    var similarMovies: [SimilarMovie] = []
    var movie: Movie
    var posterPath = ""

    // MARK: - Initializers

    init(networkService: NetworkService, movie: Movie) {
        self.networkService = networkService
        self.movie = movie
    }

    // MARK: - Public Methods

    func fetchData(completion: @escaping ((Result<Data, Error>) -> Void)) {
        networkService.setupImageFromURLImage(posterPath: movie.posterPath, completion: completion)
    }

    func fetchPosterData(completion: @escaping ((Result<Data, Error>) -> Void)) {
        networkService.setupImageFromURLImage(posterPath: posterPath, completion: completion)
    }

    func fetchSimilarMovies(completion: @escaping ((Result<[SimilarMovie], Error>) -> Void)) {
        networkService.fetchSimilarMovies(idMovie: movie.id) { result in
            switch result {
            case let .success(similarMovies):
                self.similarMovies = similarMovies
                completion(result)
            case .failure:
                completion(result)
            }
        }
    }

    func setupPoster(index: Int) {
        guard index < similarMovies.count else { return }
        posterPath = similarMovies[index].posterPath
    }
}
