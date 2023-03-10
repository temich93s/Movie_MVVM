// ListMoviesViewModelProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол вью-модель экрана со списком фильмов
protocol ListMoviesViewModelProtocol {
    var currentCategoryMovies: CategoryMovies { get set }
    var listMoviesState: ((ListMoviesState<Movie>) -> ())? { get set }
    var uploadApiKeyCompletion: VoidHandler? { get set }

    func fetchMovies()
    func fetchData(movie: Movie, completion: @escaping ((Result<Data, Error>) -> Void))
    func setupCategory(tag: Int)
    func uploadApiKey(_ key: String)
    func checkApiKey()
}
