// DetailMovieBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер экрана с описанием фильма
final class DetailMovieBuilder: DetailMovieBuilderProtocol {
    // MARK: - Public Methods

    func build(movie: Movie) -> UIViewController {
        let networkService = NetworkService()
        let detailMovieViewModel = DetailMovieViewModel(networkService: networkService, movie: movie)
        let detailMovieViewController = DetailMovieViewController(detailMovieViewModel: detailMovieViewModel)
        return detailMovieViewController
    }
}
