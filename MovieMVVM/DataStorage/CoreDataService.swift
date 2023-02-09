// CoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import UIKit

/// Сервис работы с CoreData
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Public Methods

    func saveSimilarMovie(id: Int, similarMovie: [SimilarMovie]) {
        guard let context = getContext() else { return }
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        guard let entity = NSEntityDescription.entity(forEntityName: "SimilarMovieData", in: context) else { return }
        var posters: [String] = []
        for movie in similarMovie {
            posters.append(movie.posterPath)
        }
        let movieObject = SimilarMovieData(entity: entity, insertInto: context)
        movieObject.postersPath = posters
        movieObject.id = Int64(id)
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func getSimilarMovie(id: Int) -> [SimilarMovie]? {
        guard let context = getContext() else { return nil }
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
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }

    func saveMovieData(category: CategoryMovies, movies: [Movie]) {
        guard let context = getContext() else { return }
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
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func getMovieData(category: CategoryMovies) -> [Movie]? {
        switch category {
        case .topRated:
            let topRatedMovieData = getData(entityName: "TopRatedMovie", type: TopRatedMovie.self)
            return getMovies(topRatedMovies: topRatedMovieData)
        case .popular:
            let popularMovieData = getData(entityName: "PopularMovie", type: PopularMovie.self)
            return getMovies(popularMovies: popularMovieData)
        case .upcoming:
            let upcomingMovieData = getData(entityName: "UpcomingMovie", type: UpcomingMovie.self)
            return getMovies(upcomingMovies: upcomingMovieData)
        }
    }

    // MARK: - Private Methods

    private func getData<T: NSManagedObject>(entityName: String, type: T.Type) -> [T]? {
        guard let context = getContext() else { return nil }
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
                overview: popularMovie.overview ?? "",
                posterPath: popularMovie.posterPath ?? "",
                releaseDate: popularMovie.releaseDate ?? "",
                title: popularMovie.title ?? "",
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
                overview: topRatedMovie.overview ?? "",
                posterPath: topRatedMovie.posterPath ?? "",
                releaseDate: topRatedMovie.releaseDate ?? "",
                title: topRatedMovie.title ?? "",
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
                overview: upcomingMovie.overview ?? "",
                posterPath: upcomingMovie.posterPath ?? "",
                releaseDate: upcomingMovie.releaseDate ?? "",
                title: upcomingMovie.title ?? "",
                voteAverage: upcomingMovie.voteAverage,
                voteCount: upcomingMovie.voteCount
            )
            movies.append(movie)
        }
        return movies
    }

    private func saveTopRatedMovie(movies: [Movie], context: NSManagedObjectContext) {
        deleteOldData(entity: "TopRatedMovie")
        guard let entity = NSEntityDescription.entity(forEntityName: "TopRatedMovie", in: context) else { return }
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
        deleteOldData(entity: "PopularMovie")
        guard let entity = NSEntityDescription.entity(forEntityName: "PopularMovie", in: context) else { return }
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
        deleteOldData(entity: "UpcomingMovie")
        guard let entity = NSEntityDescription.entity(forEntityName: "UpcomingMovie", in: context) else { return }
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
        guard let context = getContext() else { return }
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
            print("Detele all data in \(entity) error :", error)
        }
    }

    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
}
