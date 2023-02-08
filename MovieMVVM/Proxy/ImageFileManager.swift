// ImageFileManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Файловый менеджер изображений
final class ImageFileManager {
    // MARK: - Constants

    private enum Constants {
        static let folderName = "Images"
    }

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
        let folderUrl = documentDirectory.appendingPathComponent(Constants.folderName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: folderUrl.path) {
            do {
                try FileManager.default.createDirectory(at: folderUrl, withIntermediateDirectories: true)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        return folderUrl.appendingPathComponent(path).path
    }
}
