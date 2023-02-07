// MovieList.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - MovieList

/// MovieList: список фильмов
/// - page: номер страницы с набором фильмов
/// - results: массив с фильмами
/// - totalPages: общее количество страниц
/// - totalResults: общее количество фильмов
struct MovieList: Codable {
    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie

/// Movie: информация о фильме
/// - dataImage: сам постер фильма
/// - id: идентификатор фильма
/// - overview: краткое описание фильма
/// - posterPath: ссылка на постер фильма
/// - releaseDate: дата релиза фильма
/// - title: наименование фильма
/// - voteAverage: оценка фильма
struct Movie: Codable {
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Double

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
