// ListMoviesBuilderProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import UIKit

/// Протокол сборщика модулей экрана с описанием фильма
protocol ListMoviesBuilderProtocol {
    // MARK: - Public Methods

    func build() -> UIViewController
}
