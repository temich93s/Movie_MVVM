// CoreDataService.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import UIKit

final class CoreDataService {
    // MARK: - Public Methods

    func saveData(category: CategoryMovies, movies: [Movie]) {
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

    func getData(category: CategoryMovies) -> [Movie]? {
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
}
