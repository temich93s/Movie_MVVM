// SimilarMovies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Похожие фильмы
struct SimilarMovies: Codable {
    // MARK: - Public Properties

    /// Список похожих фильмов
    let results: [SimilarMovie]
}
