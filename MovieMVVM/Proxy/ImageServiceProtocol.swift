// ImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол загрузки изображений
protocol ImageServiceProtocol {
    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void))
}
