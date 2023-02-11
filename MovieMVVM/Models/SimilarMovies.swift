// SimilarMovies.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Похожие фильмы
struct SimilarMovies: Codable {
    /// Список похожих фильмов
    let results: [SimilarMovie]
}
