// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// fff
class ImageAPIService: LoadImageProtocol {
    // MARK: - Constants

    private enum Constants {
        static let posterPathQueryText = "https://image.tmdb.org/t/p/w500"
    }

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
