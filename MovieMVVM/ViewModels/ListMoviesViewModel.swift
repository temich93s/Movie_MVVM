// ListMoviesViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана со списком фильмов
final class ListMoviesViewModel: ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol
    var movies: [Movie] = []
    var movie: Movie?
    var currentCategoryMovies: CategoryMovies = .popular

    // MARK: - Initializers

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func fetchMovies(completion: @escaping ((Result<[Movie], Error>) -> Void)) {
        networkService.fetchData(categoryMovies: currentCategoryMovies) { result in
            switch result {
            case let .success(movies):
                self.movies = movies
                completion(result)
            case .failure:
                completion(result)
            }
        }
    }

    func fetchData(completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let movie = movie else { return }
        networkService.setupImageFromURLImage(posterPath: movie.posterPath, completion: completion)
    }

    func setupMovie(index: Int) {
        guard index < movies.count else { return }
        movie = movies[index]
    }
}
