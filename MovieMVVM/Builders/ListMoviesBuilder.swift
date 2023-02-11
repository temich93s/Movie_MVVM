// ListMoviesBuilder.swift
// Copyright © SolovevAA. All rights reserved.

import UIKit

/// Сборщик модулей экрана со списком фильмов
final class ListMoviesBuilder: ListMoviesBuilderProtocol {
    // MARK: - Public Methods

    func build() -> UIViewController {
        let networkService = NetworkService()
        let fileManager = FileManagerService()
        let imageAPIService = ImageAPIService()
        let keychainService = KeychainService()
        let coreDataService = CoreDataService()
        let proxy = Proxy(fileManager: fileManager, imageAPIService: imageAPIService)
        let imageService = ImageService(proxy: proxy)
        let listMoviesViewModel = ListMoviesViewModel(
            networkService: networkService,
            imageService: imageService,
            keychainService: keychainService,
            coreDataService: coreDataService
        )
        let listMoviesViewController = ListMoviesViewController(listMovieViewModel: listMoviesViewModel)
        return listMoviesViewController
    }
}
