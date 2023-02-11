// MockImageService.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

@testable import MovieMVVM

/// Мок имедж сервиса
final class MockImageService: ImageServiceProtocol {
    let mockPath = "pencil"

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        if path == mockPath {
            let data = Data(count: 8)
            completion(.success(data))
        }
    }
}
