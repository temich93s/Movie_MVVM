// CoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import UIKit

/// Сервис работы с CoreData
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Constants

    private enum Constants {
        static let similarMovieDataText = "SimilarMovieData"
        static let topRatedMovieText = "TopRatedMovie"
        static let popularMovieText = "PopularMovie"
        static let upcomingMovieText = "UpcomingMovie"
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

    func saveMovieData(category: CategoryMovies, movies: [Movie]) {
        guard let context = context else { return }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        switch category {
        case .topRated:
            saveTopRatedMovie(movies: movies, context: context)
        case .popular:
            savePopularMovie(movies: movies, context: context)
        case .upcoming:
            saveUpcomingMovie(movies: movies, context: context)
        }
        do {
            try context.save()
        } catch {
            context.rollback()
        }
    }

    func getMovieData(category: CategoryMovies) -> [Movie]? {
        switch category {
        case .topRated:
            let topRatedMovieData = getData(entityName: Constants.topRatedMovieText, type: TopRatedMovie.self)
            return getMovies(topRatedMovies: topRatedMovieData)
        case .popular:
            let popularMovieData = getData(entityName: Constants.popularMovieText, type: PopularMovie.self)
            return getMovies(popularMovies: popularMovieData)
        case .upcoming:
            let upcomingMovieData = getData(entityName: Constants.upcomingMovieText, type: UpcomingMovie.self)
            return getMovies(upcomingMovies: upcomingMovieData)
        }
    }

    // MARK: - Private Methods

    private func getData<T: NSManagedObject>(entityName: String, type: T.Type) -> [T]? {
        guard let context = context else { return nil }
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        let data = try? context.fetch(fetchRequest)
        return data
    }

    private func getMovies(popularMovies: [PopularMovie]?) -> [Movie]? {
        guard let popularMovies = popularMovies else { return nil }
        var movies: [Movie] = []
        for popularMovie in popularMovies {
            let movie = Movie(
                id: Int(popularMovie.id),
                overview: popularMovie.overview ?? Constants.emptyText,
                posterPath: popularMovie.posterPath ?? Constants.emptyText,
                releaseDate: popularMovie.releaseDate ?? Constants.emptyText,
                title: popularMovie.title ?? Constants.emptyText,
                voteAverage: popularMovie.voteAverage,
                voteCount: popularMovie.voteCount
            )
            movies.append(movie)
        }
        return movies
    }

    private func getMovies(topRatedMovies: [TopRatedMovie]?) -> [Movie]? {
        guard let topRatedMovies = topRatedMovies else { return nil }
        var movies: [Movie] = []
        for topRatedMovie in topRatedMovies {
            let movie = Movie(
                id: Int(topRatedMovie.id),
                overview: topRatedMovie.overview ?? Constants.emptyText,
                posterPath: topRatedMovie.posterPath ?? Constants.emptyText,
                releaseDate: topRatedMovie.releaseDate ?? Constants.emptyText,
                title: topRatedMovie.title ?? Constants.emptyText,
                voteAverage: topRatedMovie.voteAverage,
                voteCount: topRatedMovie.voteCount
            )
            movies.append(movie)
        }
        return movies
    }

    private func getMovies(upcomingMovies: [UpcomingMovie]?) -> [Movie]? {
        guard let upcomingMovies = upcomingMovies else { return nil }
        var movies: [Movie] = []
        for upcomingMovie in upcomingMovies {
            let movie = Movie(
                id: Int(upcomingMovie.id),
                overview: upcomingMovie.overview ?? Constants.emptyText,
                posterPath: upcomingMovie.posterPath ?? Constants.emptyText,
                releaseDate: upcomingMovie.releaseDate ?? Constants.emptyText,
                title: upcomingMovie.title ?? Constants.emptyText,
                voteAverage: upcomingMovie.voteAverage,
                voteCount: upcomingMovie.voteCount
            )
            movies.append(movie)
        }
        return movies
    }

    private func saveTopRatedMovie(movies: [Movie], context: NSManagedObjectContext) {
        deleteOldData(entity: Constants.topRatedMovieText)
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.topRatedMovieText, in: context)
        else { return }
        for movie in movies {
            let movieObject = TopRatedMovie(entity: entity, insertInto: context)
            movieObject.id = Int64(movie.id)
            movieObject.overview = movie.overview
            movieObject.posterPath = movie.posterPath
            movieObject.releaseDate = movie.releaseDate
            movieObject.title = movie.title
            movieObject.voteAverage = movie.voteAverage
            movieObject.voteCount = movie.voteCount
        }
    }

    private func savePopularMovie(movies: [Movie], context: NSManagedObjectContext) {
        deleteOldData(entity: Constants.popularMovieText)
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.popularMovieText, in: context)
        else { return }
        for movie in movies {
            let movieObject = PopularMovie(entity: entity, insertInto: context)
            movieObject.id = Int64(movie.id)
            movieObject.overview = movie.overview
            movieObject.posterPath = movie.posterPath
            movieObject.releaseDate = movie.releaseDate
            movieObject.title = movie.title
            movieObject.voteAverage = movie.voteAverage
            movieObject.voteCount = movie.voteCount
        }
    }

    private func saveUpcomingMovie(movies: [Movie], context: NSManagedObjectContext) {
        deleteOldData(entity: Constants.upcomingMovieText)
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.upcomingMovieText, in: context)
        else { return }
        for movie in movies {
            let movieObject = UpcomingMovie(entity: entity, insertInto: context)
            movieObject.id = Int64(movie.id)
            movieObject.overview = movie.overview
            movieObject.posterPath = movie.posterPath
            movieObject.releaseDate = movie.releaseDate
            movieObject.title = movie.title
            movieObject.voteAverage = movie.voteAverage
            movieObject.voteCount = movie.voteCount
        }
    }

    private func deleteOldData(entity: String) {
        guard let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                context.delete(objectData)
            }
            try context.save()
        } catch {
            context.rollback()
        }
    }
}
