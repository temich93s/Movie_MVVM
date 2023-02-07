// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Абстрактный координатор
class BaseCoordinator {
    // MARK: - Public Properties

    var childCoordinators: [BaseCoordinator] = []
    var window: UIWindow

    // MARK: - Initializers

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Public Methods

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        window.rootViewController = controller
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
    }
}
