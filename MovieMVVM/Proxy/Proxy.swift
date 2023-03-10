// Proxy.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Прокси загрузки изображений
final class Proxy: ImageServiceProtocol {
    // MARK: - Private Methods

    private var fileManager: FileManagerServiceProtocol
    private var imageAPIService: ImageAPIServiceProtocol

    // MARK: - Initializers

    init(fileManager: FileManagerServiceProtocol, imageAPIService: ImageAPIServiceProtocol) {
        self.fileManager = fileManager
        self.imageAPIService = imageAPIService
    }

    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        if let cacheDate = fileManager.loadImageData(path: path) {
            completion(Result.success(cacheDate))
        } else {
            imageAPIService.loadImage(path: path) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(data):
                    self.fileManager.saveImageData(path: path, data: data)
                default:
                    break
                }
                completion(result)
            }
        }
    }
}
