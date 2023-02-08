// CoreDataServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол работы с CoreData
protocol CoreDataServiceProtocol {
    func saveData(category: CategoryMovies, movies: [Movie])
    func getData(category: CategoryMovies) -> [Movie]?
}
