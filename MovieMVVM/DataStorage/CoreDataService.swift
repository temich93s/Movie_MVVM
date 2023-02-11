// CoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import UIKit

/// Сервис работы с CoreData
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let similarMovieDataText = "SimilarMovieData"
        static let movieDataText = "MovieData"
        static let emptyText = ""
    }

    // MARK: - Private Properties

    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    // MARK: - Public Methods

    func saveSimilarMovie(id: Int, similarMovie: [SimilarMovie]) {
        guard let context = context else { return }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.similarMovieDataText, in: context)
        else { return }
        var posters: [String] = []
        for movie in similarMovie {
            posters.append(movie.posterPath)
        }
        let movieObject = SimilarMovieData(entity: entity, insertInto: context)
        movieObject.postersPath = posters
        movieObject.id = Int64(id)
        do {
            try context.save()
        } catch {
            context.rollback()
        }
    }

    func getSimilarMovie(id: Int) -> [SimilarMovie]? {
        guard let context = context else { return nil }
        let fetchRequest: NSFetchRequest<SimilarMovieData> = SimilarMovieData.fetchRequest()
        do {
            let similarMovieData = try context.fetch(fetchRequest)
            var similarMovies: [SimilarMovie] = []
            for movie in similarMovieData {
                guard Int(movie.id) == id else { continue }
                guard let posters = movie.postersPath else { return nil }
                for poster in posters {
                    similarMovies.append(SimilarMovie(posterPath: poster))
                }
                return similarMovies
            }
        } catch {
            return nil
        }
        return nil
    }

    func saveMovie(category: CategoryMovies, movies: [Movie]) {
        guard let context = context else { return }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.movieDataText, in: context)
        else { return }
        for movie in movies {
            let movieObject = MovieData(entity: entity, insertInto: context)
            movieObject.id = Int64(movie.id)
            movieObject.overview = movie.overview
            movieObject.posterPath = movie.posterPath
            movieObject.releaseDate = movie.releaseDate
            movieObject.title = movie.title
            movieObject.voteAverage = movie.voteAverage
            movieObject.voteCount = movie.voteCount
            switch category {
            case .topRated:
                movieObject.topRated = true
            case .popular:
                movieObject.popular = true
            case .upcoming:
                movieObject.upcoming = true
            }
        }
        do {
            try context.save()
        } catch {
            context.rollback()
        }
    }

    func getMovie(category: CategoryMovies) -> [Movie]? {
        guard let context = context else { return nil }
        let fetchRequest = NSFetchRequest<MovieData>(entityName: Constants.movieDataText)
        let dataMovies = try? context.fetch(fetchRequest)
        guard let dataMovies = dataMovies else { return nil }
        var movies: [Movie] = []
        for dataMovie in dataMovies {
            switch category {
            case .topRated:
                guard dataMovie.topRated == true else { continue }
                movies.append(createMovie(movieData: dataMovie))
            case .popular:
                guard dataMovie.popular == true else { continue }
                movies.append(createMovie(movieData: dataMovie))
            case .upcoming:
                guard dataMovie.upcoming == true else { continue }
                movies.append(createMovie(movieData: dataMovie))
            }
        }
        return movies
    }

    // MARK: - Private Methods

    private func createMovie(movieData: MovieData) -> Movie {
        Movie(
            id: Int(movieData.id),
            overview: movieData.overview ?? Constants.emptyText,
            posterPath: movieData.posterPath ?? Constants.emptyText,
            releaseDate: movieData.releaseDate ?? Constants.emptyText,
            title: movieData.title ?? Constants.emptyText,
            voteAverage: movieData.voteAverage,
            voteCount: movieData.voteCount
        )
    }
}
