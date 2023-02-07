// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Муви API сервис
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let apiKeyQueryText = "api_key=8216e974d625f2a458a739c20007dcd6"
        static let languageQueryText = "&language=ru-RU"
        static let pageQueryText = "&page=1"
        static let themoviedbQueryText = "https://api.themoviedb.org/3/movie/"
        static let posterPathQueryText = "https://image.tmdb.org/t/p/w500"
        static let firstPartURLText = "https://api.themoviedb.org/3/movie/"
        static let secondPartURLText = "/similar?api_key=8216e974d625f2a458a739c20007dcd6&language=ru-RU&page=1"
        static let topRatedQueryText = "top_rated?"
        static let popularQueryText = "popular?"
        static let upcomingQueryText = "upcoming?"
    }

    // MARK: - Public Methods

    func fetchMovies(categoryMovies: CategoryMovies, completion: @escaping (Result<[Movie], Error>) -> Void) {
        var currentCategoryMovies = ""
        switch categoryMovies {
        case .topRated:
            currentCategoryMovies = Constants.topRatedQueryText
        case .popular:
            currentCategoryMovies = Constants.popularQueryText
        case .upcoming:
            currentCategoryMovies = Constants.upcomingQueryText
        }
        let urlString =
            "\(Constants.themoviedbQueryText)\(currentCategoryMovies)\(Constants.apiKeyQueryText)" +
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

//    func setupImageFromURLImage(posterPath: String, completion: @escaping ((Result<Data, Error>) -> Void)) {
//        guard let imageMovieNameURL = URL(string: "\(Constants.posterPathQueryText)\(posterPath)") else { return }
//        DispatchQueue.global().async {
//            do {
//                let data = try Data(contentsOf: imageMovieNameURL)
//                DispatchQueue.main.async {
//                    completion(.success(data))
//                }
//            } catch {
//                completion(.failure(error))
//            }
//        }
//    }

    func fetchSimilarMovies(idMovie: Int, completion: @escaping ((Result<[SimilarMovie], Error>) -> Void)) {
        let urlString = "\(Constants.firstPartURLText)\(idMovie)\(Constants.secondPartURLText)"
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
}
