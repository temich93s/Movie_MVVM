// KeychainService.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation
import KeychainSwift

/// Сервис работы с Keychain
struct KeychainService: KeychainServiceProtocol {
    // MARK: - Public Methods

    func save(_ keyValue: String, forKey: KeychainKey) {
        KeychainSwift().set(keyValue, forKey: forKey.rawValue)
    }

    func get(forKey: KeychainKey) -> String? {
        KeychainSwift().get(forKey.rawValue)
    }
}
