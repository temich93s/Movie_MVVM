// SimilarMovies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - SimilarMovies

/// SimilarMovies: Похожие фильмы
/// - results: список похожих фильмов
struct SimilarMovies: Codable {
    let results: [SimilarMovie]
}

// MARK: - SimilarMovie

/// SimilarMovie: похожий фильм
/// - posterPath: постер похожего письма
struct SimilarMovie: Codable {
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
