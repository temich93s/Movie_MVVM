// MockProxy.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

@testable import MovieMVVM

/// Мок прокси
final class MockProxy: ImageServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPencilText = "pencil"
        static let mockNumber = 8
    }

    // MARK: - Public Properties

    let mockPath = Constants.mockPencilText

    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        if path == mockPath {
            let data = Data(count: Constants.mockNumber)
            completion(.success(data))
        }
    }
}
