// CoreDataServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол работы с CoreData
protocol CoreDataServiceProtocol {
    func saveMovieData(category: CategoryMovies, movies: [Movie])
    func getMovieData(category: CategoryMovies) -> [Movie]?
}
