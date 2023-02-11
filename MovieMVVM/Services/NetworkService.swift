// NetworkService.swift
// Copyright © SolovevAA. All rights reserved.

import UIKit

/// Муви API сервис
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let apiKeyText = "api_key="
        static let languageQueryText = "&language=ru-RU"
        static let pageQueryText = "&page=1"
        static let themoviedbQueryText = "https://api.themoviedb.org/3/movie/"
        static let similarQueryText = "/similar?"
        static let topRatedQueryText = "top_rated?"
        static let popularQueryText = "popular?"
        static let upcomingQueryText = "upcoming?"
        static let emptyText = ""
    }

    // MARK: - Private Properties

    private var apiKey: String?

    // MARK: - Public Methods

    func fetchMovies(categoryMovies: CategoryMovies, completion: @escaping (Result<[Movie], Error>) -> Void) {
        var currentCategoryMovies = Constants.emptyText
        switch categoryMovies {
        case .topRated:
            currentCategoryMovies = Constants.topRatedQueryText
        case .popular:
            currentCategoryMovies = Constants.popularQueryText
        case .upcoming:
            currentCategoryMovies = Constants.upcomingQueryText
        }
        guard let apiKey = apiKey else { return }
        let urlString =
            "\(Constants.themoviedbQueryText)\(currentCategoryMovies)\(Constants.apiKeyText)\(apiKey)" +
            "\(Constants.languageQueryText)\(Constants.pageQueryText)\(Constants.pageQueryText)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(MovieList.self, from: data).movies
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                guard let error = error else { return }
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void)) {
        guard let apiKey = apiKey else { return }
        let urlString =
            "\(Constants.themoviedbQueryText)\(idMovie)\(Constants.similarQueryText)" +
            "\(Constants.apiKeyText)\(apiKey)\(Constants.languageQueryText)\(Constants.pageQueryText)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                do {
                    let similarMovies = try JSONDecoder().decode(SimilarMovies.self, from: data).results
                    DispatchQueue.main.async {
                        completion(.success(similarMovies))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func setupAPIKey(_ apiKey: String) {
        self.apiKey = apiKey
    }
}
