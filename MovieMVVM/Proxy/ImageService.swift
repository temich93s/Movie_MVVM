// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис загрузки изображений
final class ImageService: LoadImageProtocol {
    // MARK: - Private Properties

    private var proxy: LoadImageProtocol

    // MARK: - Initializers

    init(proxy: LoadImageProtocol) {
        self.proxy = proxy
    }

    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        proxy.loadImage(path: path, completion: completion)
    }
}
