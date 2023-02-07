// ImageFileManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Файловый менеджер
final class ImageFileManager {
    // MARK: - Private Properties

    private let tmpDirectory = FileManager.default.temporaryDirectory

    // MARK: - Public Methods

    func loadData(path: String) -> Data? {
        let testFile = tmpDirectory.appendingPathComponent(path).path
        guard let url = URL(string: testFile) else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }

    func saveData(path: String, data: Data) {
        let testFile = tmpDirectory.appendingPathComponent(path).path
        FileManager.default.createFile(atPath: testFile, contents: data, attributes: nil)
    }
}
