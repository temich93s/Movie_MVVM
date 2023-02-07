// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// dd
class Proxy: LoadImageProtocol {
    private var fileManager: FileManager
    private var imageAPIService: LoadImageProtocol

    init(fileManager: FileManager, imageAPIService: LoadImageProtocol) {
        self.fileManager = fileManager
        self.imageAPIService = imageAPIService
    }

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        if let cacheDate = fileManager.checkCache(path: path) {
            completion(Result.success(cacheDate))
        } else {
            imageAPIService.loadImage(path: path, completion: completion)
        }
    }
}
