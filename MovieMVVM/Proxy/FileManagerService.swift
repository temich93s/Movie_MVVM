// FileManagerService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис файлового менеджера
final class FileManagerService: FileManagerServiceProtocol {
    // MARK: - Public Methods

    func loadImageData(path: String) -> Data? {
        guard let imagePath = makeImagePath(path: path) else { return nil }
        let imagePathURL = URL(filePath: imagePath)
        let data = try? Data(contentsOf: imagePathURL)
        return data
    }

    func saveImageData(path: String, data: Data) {
        guard let imagePath = makeImagePath(path: path) else { return }
        FileManager.default.createFile(atPath: imagePath, contents: data)
    }

    // MARK: - Private Methods

    private func makeImagePath(path: String) -> String? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        return documentDirectory.appendingPathComponent(path).path
    }
}
