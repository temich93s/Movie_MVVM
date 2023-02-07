// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class ImageService: LoadImageProtocol {
    var proxy: LoadImageProtocol

    init(proxy: LoadImageProtocol) {
        self.proxy = proxy
    }

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        proxy.loadImage(path: path, completion: completion)
    }
}
