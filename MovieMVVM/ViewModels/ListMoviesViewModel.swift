// ListMoviesViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана со списком фильмов
final class ListMoviesViewModel: ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var networkService: NetworkServiceProtocol
    var imageService: LoadImageProtocol
    var movies: [Movie] = []
    var movie: Movie?
    var currentCategoryMovies: CategoryMovies = .popular
    var listMoviesState: ((ListMoviesState) -> ())?

    // MARK: - Initializers

    init(networkService: NetworkService, imageService: LoadImageProtocol) {
        self.networkService = networkService
        self.imageService = imageService
    }

    // MARK: - Public Methods

    func fetchData(completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let movie = movie else { return }
        imageService.loadImage(path: movie.posterPath, completion: completion)
    }

    func setupMovie(index: Int) {
        guard index < movies.count else { return }
        movie = movies[index]
    }

    func fetchMovies() {
        listMoviesState?(.loading)
        networkService.fetchMovies(categoryMovies: currentCategoryMovies) { result in
            switch result {
            case let .success(movies):
                self.movies = movies
                self.listMoviesState?(.success)
            case .failure:
                self.listMoviesState?(.failure)
            }
        }
    }

    func setupCategory(tag: Int) {
        switch tag {
        case 0:
            currentCategoryMovies = .popular
        case 1:
            currentCategoryMovies = .topRated
        case 2:
            currentCategoryMovies = .upcoming
        default:
            break
        }
        fetchMovies()
    }
}
