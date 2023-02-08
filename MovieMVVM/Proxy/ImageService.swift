// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис загрузки изображений
final class ImageService: ImageServiceProtocol {
    // MARK: - Private Properties

    private var proxy: ImageServiceProtocol

    // MARK: - Initializers

    init(proxy: ImageServiceProtocol) {
        self.proxy = proxy
    }

    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        proxy.loadImage(path: path, completion: completion)
    }
}
