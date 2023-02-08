// SimilarMovie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Похожий фильм
struct SimilarMovie: Codable {
    /// Постер похожего письма
    let posterPath: String

    // MARK: - Enum

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
