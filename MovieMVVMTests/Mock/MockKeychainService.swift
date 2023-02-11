// MockKeychainService.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

@testable import MovieMVVM

/// Мок кейчейна
final class MockKeychainService: KeychainServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let mockText = "mock"
    }

    // MARK: - Public Properties

    var keyValue: String?

    // MARK: - Public Methods

    func save(_ keyValue: String, forKey: KeychainKey) {
        self.keyValue = keyValue
    }

    func get(forKey: KeychainKey) -> String? {
        Constants.mockText
    }
}
