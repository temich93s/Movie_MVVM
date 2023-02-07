// MovieList.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список фильмов
struct MovieList: Codable {
    // MARK: - Public Properties

    /// Номер страницы с набором фильмов
    let page: Int
    /// Массив с фильмами
    let movies: [Movie]
    /// Общее количество страниц
    let totalPages: Int
    /// Общее количество фильмов
    let totalResults: Int

    // MARK: - Enum

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
