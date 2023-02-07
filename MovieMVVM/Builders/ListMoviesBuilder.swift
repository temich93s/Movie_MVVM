// ListMoviesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билдер экрана со списком фильмов
final class ListMoviesBuilder: ListMoviesBuilderProtocol {
    // MARK: - Public Methods

    func build() -> UIViewController {
        let networkService = NetworkService()
        let fileManager = ImageFileManager()
        let imageAPIService = ImageAPIService()
        let proxy = Proxy(fileManager: fileManager, imageAPIService: imageAPIService)
        let imageService = ImageService(proxy: proxy)
        let listMoviesViewModel = ListMoviesViewModel(networkService: networkService, imageService: imageService)
        let listMoviesViewController = ListMoviesViewController(listMovieViewModel: listMoviesViewModel)
        return listMoviesViewController
    }
}
