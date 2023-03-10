// KeychainServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation
import KeychainSwift

/// Протокол сервиса Keychain
protocol KeychainServiceProtocol {
    func save(_ keyValue: String, forKey: KeychainKey)
    func get(forKey: KeychainKey) -> String?
}
