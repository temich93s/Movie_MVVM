// LoadImageProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол загрузки изображений
protocol LoadImageProtocol {
    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void))
}
