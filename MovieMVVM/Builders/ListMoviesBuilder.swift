// ListMoviesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер экрана со списком фильмов
final class ListMoviesBuilder: ListMoviesBuilderProtocol {
    // MARK: - Public Methods

    func build() -> UIViewController {
        let networkService = NetworkService()
        let listMoviesViewModel = ListMoviesViewModel(networkService: networkService)
        let listMoviesViewController = ListMoviesViewController(listMovieViewModel: listMoviesViewModel)
        return listMoviesViewController
    }
}
