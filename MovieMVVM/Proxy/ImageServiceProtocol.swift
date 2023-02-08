// ImageServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол загрузки изображений
protocol ImageServiceProtocol {
    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void))
}
