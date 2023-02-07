// DetailMovieViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана с выбранным фильмом
final class DetailMovieViewModel: DetailMovieViewModelProtocol {
    // MARK: - Constants

    private enum Constants {
        static let emptyText = ""
    }

    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol
    var imageService: LoadImageProtocol
    var similarMovies: [SimilarMovie] = []
    var movie: Movie
    var posterPath = Constants.emptyText

    // MARK: - Initializers

    init(networkService: NetworkService, imageService: LoadImageProtocol, movie: Movie) {
        self.networkService = networkService
        self.imageService = imageService
        self.movie = movie
    }

    // MARK: - Public Methods

    func fetchData(completion: @escaping ((Result<Data, Error>) -> Void)) {
        imageService.loadImage(path: movie.posterPath, completion: completion)
    }

    func fetchPosterData(completion: @escaping ((Result<Data, Error>) -> Void)) {
        imageService.loadImage(path: posterPath, completion: completion)
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
