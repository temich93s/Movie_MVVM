// CoreDataServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол работы с CoreData
protocol CoreDataServiceProtocol {
    func saveSimilarMovie(id: Int, similarMovie: [SimilarMovie])
    func getSimilarMovie(id: Int) -> [SimilarMovie]?
    func saveMovie(category: CategoryMovies, movies: [Movie])
    func getMovie(category: CategoryMovies) -> [Movie]?
}
