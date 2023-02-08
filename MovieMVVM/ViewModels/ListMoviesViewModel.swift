// ListMoviesViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью-модель экрана со списком фильмов
final class ListMoviesViewModel: ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var currentCategoryMovies: CategoryMovies = .popular
    var listMoviesState: ((ListMoviesState<Movie>) -> ())?

    // MARK: - Private Properties

    var networkService: NetworkServiceProtocol
    var imageService: ImageServiceProtocol

    // MARK: - Initializers

    init(networkService: NetworkService, imageService: ImageServiceProtocol) {
        self.networkService = networkService
        self.imageService = imageService
    }

    // MARK: - Public Methods

    func fetchData(movie: Movie, completion: @escaping ((Result<Data, Error>) -> Void)) {
        imageService.loadImage(path: movie.posterPath, completion: completion)
    }

    func fetchMovies() {
        listMoviesState?(.loading)
        networkService.fetchMovies(categoryMovies: currentCategoryMovies) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.listMoviesState?(.success(movies))
            case let .failure(error):
                self.listMoviesState?(.failure(error))
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
