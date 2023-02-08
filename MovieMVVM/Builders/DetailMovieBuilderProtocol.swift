// DetailMovieBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сборщика модулей экрана с описанием фильма
protocol DetailMovieBuilderProtocol {
    // MARK: - Public Methods

    func build(movie: Movie) -> UIViewController
}
