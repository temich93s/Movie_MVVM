// ListMoviesViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана со списком фильмов
final class ListMoviesViewModel: ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol
    var networkServiceCompletion: ((Result<[Movie], Error>) -> Void)?
    var movies: [Movie] = []
    var movie: Movie?
    var currentCategoryMovies: CategoryMovies = .popular {
        didSet {
            fetchMovies()
        }
    }

    // MARK: - Initializers

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    // MARK: - Public Methods

    func fetchMovies() {
        guard let networkServiceCompletion = networkServiceCompletion else { return }
        networkService.fetchData(categoryMovies: currentCategoryMovies) { result in
            switch result {
            case let .success(movies):
                self.movies = movies
                networkServiceCompletion(result)
            case .failure:
                networkServiceCompletion(result)
            }
        }
    }

    func fetchData(dataCompletion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let movie = movie else { return }
        networkService.setupImageFromURLImage(posterPath: movie.posterPath, completion: dataCompletion)
    }

    func setupMovie(index: Int) {
        guard index < movies.count else { return }
        movie = movies[index]
    }
}
