// KeychainService.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation
import KeychainSwift

/// Сервис работы с Keychain
struct KeychainService: KeychainServiceProtocol {
    // MARK: - Private Properties

    private let keychainSwift = KeychainSwift()

    // MARK: - Public Methods

    func save(_ keyValue: String, forKey: KeychainKey) {
        keychainSwift.set(keyValue, forKey: forKey.rawValue)
    }

    func get(forKey: KeychainKey) -> String? {
        keychainSwift.get(forKey.rawValue)
    }
}
