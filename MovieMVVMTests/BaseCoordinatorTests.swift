// BaseCoordinatorTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование координатора
final class BaseCoordinatorTests: XCTestCase {
    // MARK: - Private Properties

    private let mockCoordinator = MockCoordinator(window: UIWindow())

    private var baseCoordinator: BaseCoordinator?

    // MARK: - Public Methods

    override func setUp() {
        baseCoordinator = BaseCoordinator(window: UIWindow())
    }

    override func tearDown() {
        baseCoordinator = nil
    }

    func testAddDependency() {
        baseCoordinator?.addDependency(mockCoordinator)
        XCTAssertTrue(baseCoordinator?.childCoordinators.first === mockCoordinator)
    }

    func testRemoveDependency() {
        baseCoordinator?.addDependency(mockCoordinator)
        baseCoordinator?.removeDependency(mockCoordinator)
        guard let childCoordinators = baseCoordinator?.childCoordinators else { return }
        XCTAssertTrue(childCoordinators.isEmpty)
    }
}
