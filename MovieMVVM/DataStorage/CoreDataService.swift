// CoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import UIKit

/// Сервис работы с CoreData
final class CoreDataService: CoreDataServiceProtocol {
    // MARK: - Public Methods

    func saveSimilarMovie(id: Int, similarMovie: [SimilarMovie]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        switch category {
        case .topRated:
            return getTopRatedMovie(context: context)
        case .popular:
            return getPopularMovie(context: context)
        case .upcoming:
            return getUpcomingMovie(context: context)
        }
    }

    // MARK: - Private Methods

    private func getTopRatedMovie(context: NSManagedObjectContext) -> [Movie]? {
        let fetchRequest: NSFetchRequest<TopRatedMovie> = TopRatedMovie.fetchRequest()
        do {
            let moviesCoreData = try context.fetch(fetchRequest)
            var movies: [Movie] = []
            for movieCoreData in moviesCoreData {
                let movie = Movie(
                    id: Int(movieCoreData.id),
                    overview: movieCoreData.overview ?? "",
                    posterPath: movieCoreData.posterPath ?? "",
                    releaseDate: movieCoreData.releaseDate ?? "",
                    title: movieCoreData.title ?? "",
                    voteAverage: movieCoreData.voteAverage,
                    voteCount: movieCoreData.voteCount
                )
                movies.append(movie)
            }
            return movies
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }

    private func getPopularMovie(context: NSManagedObjectContext) -> [Movie]? {
        let fetchRequest: NSFetchRequest<PopularMovie> = PopularMovie.fetchRequest()
        do {
            let moviesCoreData = try context.fetch(fetchRequest)
            var movies: [Movie] = []
            for movieCoreData in moviesCoreData {
                let movie = Movie(
                    id: Int(movieCoreData.id),
                    overview: movieCoreData.overview ?? "",
                    posterPath: movieCoreData.posterPath ?? "",
                    releaseDate: movieCoreData.releaseDate ?? "",
                    title: movieCoreData.title ?? "",
                    voteAverage: movieCoreData.voteAverage,
                    voteCount: movieCoreData.voteCount
                )
                movies.append(movie)
            }
            return movies
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }

    private func getUpcomingMovie(context: NSManagedObjectContext) -> [Movie]? {
        let fetchRequest: NSFetchRequest<UpcomingMovie> = UpcomingMovie.fetchRequest()
        do {
            let moviesCoreData = try context.fetch(fetchRequest)
            var movies: [Movie] = []
            for movieCoreData in moviesCoreData {
                let movie = Movie(
                    id: Int(movieCoreData.id),
                    overview: movieCoreData.overview ?? "",
                    posterPath: movieCoreData.posterPath ?? "",
                    releaseDate: movieCoreData.releaseDate ?? "",
                    title: movieCoreData.title ?? "",
                    voteAverage: movieCoreData.voteAverage,
                    voteCount: movieCoreData.voteCount
                )
                movies.append(movie)
            }
            return movies
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
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

    func deleteOldData(entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
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
}
