// ImageAPIServiceProtocol.swift
// Copyright © SolovevAA. All rights reserved.

import Foundation

/// Протокол айпи сервиса загрузки изображений
protocol ImageAPIServiceProtocol {
    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void))
}
