// ListMoviesViewModel.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Вью-модель экрана со списком фильмов
final class ListMoviesViewModel: ListMoviesViewModelProtocol {
    // MARK: - Public Properties

    var currentCategoryMovies: CategoryMovies = .popular
    var listMoviesState: ((ListMoviesState<Movie>) -> ())?
    var uploadApiKeyCompletion: VoidHandler?

    // MARK: - Private Properties

    private var networkService: NetworkServiceProtocol
    private var imageService: ImageServiceProtocol
    private var keychainService: KeychainServiceProtocol
    private var coreDataService: CoreDataServiceProtocol

    // MARK: - Initializers

    init(
        networkService: NetworkService,
        imageService: ImageServiceProtocol,
        keychainService: KeychainServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.networkService = networkService
        self.imageService = imageService
        self.keychainService = keychainService
        self.coreDataService = coreDataService
    }

    // MARK: - Public Methods

    func fetchData(movie: Movie, completion: @escaping ((Result<Data, Error>) -> Void)) {
        imageService.loadImage(path: movie.posterPath, completion: completion)
    }

    func fetchMovies() {
        listMoviesState?(.loading)
        if let coreDataMovies = coreDataService.getMovie(category: currentCategoryMovies) {
            listMoviesState?(.success(coreDataMovies))
        }
        networkService.fetchMovies(categoryMovies: currentCategoryMovies) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.coreDataService.saveMovie(
                    category: self.currentCategoryMovies, movies: movies
                )
                self.listMoviesState?(.success(movies))
            case let .failure(error):
                self.listMoviesState?(.failure(error))
            }
        }
    }

    func checkApiKey() {
        guard let apiKey = keychainService.get(forKey: .apiKey) else {
            uploadApiKeyCompletion?()
            return
        }
        networkService.setupAPIKey(apiKey)
    }

    func uploadApiKey(_ key: String) {
        keychainService.save(key, forKey: .apiKey)
        networkService.setupAPIKey(key)
        fetchMovies()
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
