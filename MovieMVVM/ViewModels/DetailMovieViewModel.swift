// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана с выбранным фильмом
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol
    var imageService: LoadImageProtocol
    var similarMovies: [SimilarMovie] = []
    var movie: Movie
    var posterPath = ""
    var similarMoviesCompletion: ((Result<[SimilarMovie], Error>) -> Void)?
    var similarPosterCompletion: ((Result<Data, Error>) -> Void)?
    var mainPosterCompletion: ((Result<Data, Error>) -> Void)?

    // MARK: - Initializers

    init(networkService: NetworkService, imageService: LoadImageProtocol, movie: Movie) {
        self.networkService = networkService
        self.imageService = imageService
        self.movie = movie
    }

    // MARK: - Public Methods

    func fetchMainPosterData() {
        guard let mainPosterCompletion = mainPosterCompletion else { return }
        imageService.loadImage(path: movie.posterPath, completion: mainPosterCompletion)
    }

    func fetchSimilarPosterData() {
        guard let similarPosterCompletion = similarPosterCompletion else { return }
        imageService.loadImage(path: posterPath, completion: similarPosterCompletion)
    }

    func fetchSimilarMovies() {
        guard let similarMoviesCompletion = similarMoviesCompletion else { return }
        networkService.fetchSimilarMovies(idMovie: movie.id) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(similarMovies):
                    self.similarMovies = similarMovies
                    similarMoviesCompletion(result)
                case .failure:
                    similarMoviesCompletion(result)
                }
            }
        }
    }

    func setupPoster(index: Int) {
        guard index < similarMovies.count else { return }
        posterPath = similarMovies[index].posterPath
    }

    func setupSimilarPosterCompetion(completion: ((Result<Data, Error>) -> Void)?) {
        similarPosterCompletion = completion
    }
}
