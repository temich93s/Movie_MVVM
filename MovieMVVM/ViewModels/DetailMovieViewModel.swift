// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана с выбранным фильмом
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol
    var dataCompletion: ((Result<Data, Error>) -> Void)?
    var similarMovieCompletion: ((Result<[SimilarMovie], Error>) -> Void)?
    var similarMovies: [SimilarMovie] = []
    var movie: Movie
    var posterPath = ""

    // MARK: - Initializers

    init(networkService: NetworkService, movie: Movie) {
        self.networkService = networkService
        self.movie = movie
    }

    // MARK: - Public Methods

    func fetchData() {
        guard let dataCompletion = dataCompletion else { return }
        networkService.setupImageFromURLImage(posterPath: movie.posterPath, completion: dataCompletion)
    }

    func fetchPosterData(dataPosterCompletion: @escaping ((Result<Data, Error>) -> Void)) {
        networkService.setupImageFromURLImage(posterPath: posterPath, completion: dataPosterCompletion)
    }

    func fetchSimilarMovies() {
        guard let similarMovieCompletion = similarMovieCompletion else { return }
        networkService.fetchSimilarMovies(idMovie: movie.id) { result in
            switch result {
            case let .success(similarMovies):
                self.similarMovies = similarMovies
                similarMovieCompletion(result)
            case .failure:
                similarMovieCompletion(result)
            }
        }
    }

    func setupPoster(index: Int) {
        guard index < similarMovies.count else { return }
        posterPath = similarMovies[index].posterPath
    }
}
