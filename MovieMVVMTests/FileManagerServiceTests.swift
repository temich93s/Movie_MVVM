// FileManagerServiceTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование файлового сервиса
final class FileManagerServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockPencilText = "pencil"
        static let mockNumber = 8
    }

    // MARK: - Private Properties

    let mockProxy = MockProxy()
    let mockPath = Constants.mockPencilText

    var fileManagerService: FileManagerService?

    // MARK: - Public Methods

    override func setUp() {
        fileManagerService = FileManagerService()
    }

    override func tearDown() {
        fileManagerService = nil
    }

    func testSaveAndLoadImage() {
        let mockData = Data(count: Constants.mockNumber)
        fileManagerService?.saveImageData(path: Constants.mockPencilText, data: mockData)
        let data = fileManagerService?.loadImageData(path: Constants.mockPencilText)
        XCTAssertEqual(mockData, data)
    }
}
