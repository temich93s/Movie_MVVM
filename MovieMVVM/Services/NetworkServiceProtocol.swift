// NetworkServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол муви API сервис
protocol NetworkServiceProtocol {
    func fetchMovies(categoryMovies: CategoryMovies, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void))
}
