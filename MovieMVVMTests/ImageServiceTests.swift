// ImageServiceTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование имедж сервис
final class ImageServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPencilText = "pencil"
        static let mockNumber = 8
    }

    // MARK: - Private Properties

    private let mockProxy = MockProxy()
    private let mockPath = Constants.mockPencilText

    private var imageService: ImageService?

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
                let data = Data(count: Constants.mockNumber)
                XCTAssertEqual(mockData, data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        })
    }
}
