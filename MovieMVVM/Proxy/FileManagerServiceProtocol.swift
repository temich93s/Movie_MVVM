// FileManagerServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервиса файлового менеджера
protocol FileManagerServiceProtocol {
    func loadImageData(path: String) -> Data?
    func saveImageData(path: String, data: Data)
}
