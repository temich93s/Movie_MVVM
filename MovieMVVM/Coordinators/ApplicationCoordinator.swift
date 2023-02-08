// ApplicationCoordinator.swift
// Copyright © SolovevAA. All rights reserved.

import UIKit

/// Главный координатор
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Methods

    override func start() {
        toMovieCoordinator()
    }

    // MARK: - Private Methods

    private func toMovieCoordinator() {
        let coordinator = MovieCoordinator(window: window)
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
