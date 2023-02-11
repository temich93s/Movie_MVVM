// ImageServiceTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование имедж сервис
final class ImageServiceTests: XCTestCase {
    // MARK: - Private Properties

    let mockProxy = MockProxy()
    let mockPath = "pencil"

    var imageService: ImageService?

    // MARK: - Public Methods

    override func setUp() {
        imageService = ImageService(proxy: mockProxy)
    }

    override func tearDown() {
        imageService = nil
    }

    func testLoadImage() {
        imageService?.loadImage(path: mockPath, completion: { result in
            switch result {
            case let .success(mockData):
                let data = Data(count: 8)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}

// func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
//    proxy.loadImage(path: path, completion: completion)
// }
