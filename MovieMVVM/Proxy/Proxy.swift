// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Прокси загрузки изображений
final class Proxy: LoadImageProtocol {
    // MARK: - Private Methods

    private var fileManager: ImageFileManager
    private var imageAPIService: LoadImageProtocol

    // MARK: - Initializers

    init(fileManager: ImageFileManager, imageAPIService: LoadImageProtocol) {
        self.fileManager = fileManager
        self.imageAPIService = imageAPIService
    }

    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        if let cacheDate = fileManager.loadData(path: path) {
            completion(Result.success(cacheDate))
        } else {
            imageAPIService.loadImage(path: path) { result in
                switch result {
                case let .success(data):
                    self.fileManager.saveData(path: path, data: data)
                default:
                    break
                }
                completion(result)
            }
        }
    }
}
