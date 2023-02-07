// DetailMovieBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер экрана с описанием фильма
final class DetailMovieBuilder: DetailMovieBuilderProtocol {
    // MARK: - Public Methods

    func build(movie: Movie) -> UIViewController {
        let networkService = NetworkService()
        let fileManager = ImageFileManager()
        let imageAPIService = ImageAPIService()
        let proxy = Proxy(fileManager: fileManager, imageAPIService: imageAPIService)
        let imageService = ImageService(proxy: proxy)
        let detailMovieViewModel = DetailMovieViewModel(
            networkService: networkService,
            imageService: imageService,
            movie: movie
        )
        let detailMovieViewController = DetailMovieViewController(detailMovieViewModel: detailMovieViewModel)
        return detailMovieViewController
    }
}
