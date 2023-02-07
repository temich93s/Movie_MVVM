// DetailMovieBuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера экрана с описанием фильма
protocol DetailMovieBuilderProtocol {
    // MARK: - Public Methods

    func build(movie: Movie) -> UIViewController
}
