// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол муви API сервис
protocol NetworkServiceProtocol {
    // MARK: - Public Methods

    func fetchData(categoryMovies: CategoryMovies, completion: @escaping (Result<[Movie], Error>) -> Void)
    func setupImageFromURLImage(posterPath: String, completion: @escaping ((Result<Data, Error>) -> Void))
    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void))
}
