// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис загрузки изображений из сети
final class ImageAPIService: ImageAPIServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let posterPathQueryText = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Public Methods

    func loadImage(path: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let url = URL(string: "\(Constants.posterPathQueryText)\(path)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if error == nil {
                    guard let data = data else { return }
                    completion(.success(data))
                } else {
                    guard let error = error else { return }
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
