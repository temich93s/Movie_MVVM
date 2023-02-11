// MovieCoordinator.swift
// Copyright © SolovevAA. All rights reserved.

import UIKit

/// Координатор потока информации о фильмах
final class MovieCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?

    // MARK: - Public Methods

    override func start() {
        showMainModule()
    }

    // MARK: - Private Methods

    private func showMainModule() {
        let controller = ListMoviesBuilder().build()
        guard let controller = controller as? ListMoviesViewController else { return }

        controller.toDetailMovie = { [weak self] movie in
            let detailMovieViewController = DetailMovieBuilder().build(movie: movie)
            self?.rootController?.pushViewController(detailMovieViewController, animated: false)
        }

        controller.onFinishFlow = { [weak self] in
            self?.onFinishFlow?()
        }

        rootController = UINavigationController(rootViewController: controller)
        guard let rootController = rootController else { return }
        setAsRoot(rootController)
    }
}
