// Movie.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о фильме
struct Movie: Codable {
    /// Идентификатор фильма
    let id: Int
    /// Краткое описание фильма
    let overview: String
    /// Ссылка на постер фильма
    let posterPath: String
    /// Дата релиза фильма
    let releaseDate: String
    /// Наименование фильма
    let title: String
    /// Оценка фильма
    let voteAverage: Double
    /// Количество голосов
    let voteCount: Double

    // MARK: - Enum

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
