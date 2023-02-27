// KeychainServiceTests.swift
// Copyright © SolovevAA. All rights reserved.

import XCTest

@testable import MovieMVVM

/// Тестирование кейчейна
final class KeychainServiceTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockValue = "mock"
    }

    // MARK: - Private Properties

    private var keychainService: KeychainServiceProtocol?

    // MARK: - Public Methods

    override func setUp() {
        keychainService = KeychainService()
    }

    override func tearDown() {
        keychainService = nil
    }

    func testKeychainService() {
        let mockValue = Constants.mockValue
        keychainService?.save(mockValue, forKey: .apiKey)
        let catchMockValue = keychainService?.get(forKey: .apiKey)
        XCTAssertNotNil(catchMockValue)
        guard let catchMockValue = catchMockValue else { return }
        XCTAssertEqual(mockValue, catchMockValue)
    }
}
