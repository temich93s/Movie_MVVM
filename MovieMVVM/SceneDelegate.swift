// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сцена приложения
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties

    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    // MARK: - Public Methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let window = window else { return }
        coordinator = ApplicationCoordinator(window: window)
        coordinator?.start()
    }
}
