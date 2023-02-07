// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let listMoviesViewController = ListMoviesViewController()
        let mainNavigationController = UINavigationController(rootViewController: listMoviesViewController)
        window?.rootViewController = mainNavigationController
        window?.backgroundColor = UIColor.white
    }
}
