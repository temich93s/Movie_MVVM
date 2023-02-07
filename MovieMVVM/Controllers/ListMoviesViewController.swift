// ListMoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - ListMoviesViewController

/// Экран со списком фильмов
final class ListMoviesViewController: UIViewController {
    // MARK: - Enum

    enum CurrentCategoryMovies {
        case topRated
        case popular
        case upcoming
    }

    // MARK: - Constants

    private enum Constants {
        static let systemPinkColorName = "SystemPinkColor"
        static let systemLightGrayColorName = "SystemLightGrayColor"
        static let apiKeyQueryText = "api_key=8216e974d625f2a458a739c20007dcd6"
        static let languageQueryText = "&language=ru-RU"
        static let pageQueryText = "&page=1"
        static let regionQueryText = "&region=ru"
        static let topRatedQueryText = "top_rated?"
        static let popularQueryText = "popular?"
        static let upcomingQueryText = "upcoming?"
        static let themoviedbQueryText = "https://api.themoviedb.org/3/movie/"
        static let posterPathQueryText = "https://image.tmdb.org/t/p/w500"
        static let moviesText = "Movies"
        static let popularText = "Popular"
        static let topRatedText = "Top Rated"
        static let upComingText = "Up Coming"
        static let movieTableViewCellText = "MovieTableViewCell"
    }

    // MARK: - Private Visual Properties

    private lazy var popularButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.popularText, for: .normal)
        button.backgroundColor = UIColor(named: Constants.systemPinkColorName)
        button.layer.cornerRadius = 15
        button.tag = 0
        button.addTarget(self, action: #selector(catedoryButtonAction(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var topRatedButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.topRatedText, for: .normal)
        button.backgroundColor = UIColor(named: Constants.systemLightGrayColorName)
        button.layer.cornerRadius = 15
        button.tag = 1
        button.addTarget(self, action: #selector(catedoryButtonAction(sender:)), for: .touchUpInside)
        return button
    }()

    private lazy var upComingButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.upComingText, for: .normal)
        button.backgroundColor = UIColor(named: Constants.systemLightGrayColorName)
        button.layer.cornerRadius = 15
        button.tag = 2
        button.addTarget(self, action: #selector(catedoryButtonAction(sender:)), for: .touchUpInside)
        return button
    }()

    private let mainActivityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = UIColor(named: Constants.systemPinkColorName)
        activity.startAnimating()
        return activity
    }()

    private let listMoviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieTableViewCellText)
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 15
        tableView.separatorStyle = .none
        return tableView
    }()

    private let refreshControl = UIRefreshControl()

    // MARK: - Private Properties

    private var movies: [Movie]? = []

    private lazy var buttons: [UIButton] = [popularButton, topRatedButton, upComingButton]

    private var currentCategoryMovies: CurrentCategoryMovies = .popular

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    @objc private func catedoryButtonAction(sender: UIButton) {
        mainActivityIndicatorView.startAnimating()
        mainActivityIndicatorView.isHidden = false
        setupActiveButton(pressedButton: sender)
        switch sender.tag {
        case 0:
            currentCategoryMovies = .popular
            fetchData(categoryMovies: Constants.popularQueryText)
        case 1:
            currentCategoryMovies = .topRated
            fetchData(categoryMovies: Constants.topRatedQueryText)
        case 2:
            currentCategoryMovies = .upcoming
            fetchData(categoryMovies: Constants.upcomingQueryText)
        default:
            break
        }
    }

    @objc private func refreshAction() {
        switch currentCategoryMovies {
        case .popular:
            fetchData(categoryMovies: Constants.popularQueryText)
        case .topRated:
            fetchData(categoryMovies: Constants.topRatedQueryText)
        case .upcoming:
            fetchData(categoryMovies: Constants.upcomingQueryText)
        }
        refreshControl.endRefreshing()
    }

    private func setupView() {
        title = Constants.moviesText
        fetchData(categoryMovies: Constants.popularQueryText)
        listMoviesTableView.delegate = self
        listMoviesTableView.dataSource = self
        listMoviesTableView.addSubview(refreshControl)
        addSubview()
        setupConstraint()
        setupRefreshControl()
    }

    private func addSubview() {
        view.addSubview(popularButton)
        view.addSubview(topRatedButton)
        view.addSubview(upComingButton)
        view.addSubview(listMoviesTableView)
        view.addSubview(mainActivityIndicatorView)
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: Constants.systemPinkColorName)
    }

    private func setupConstraint() {
        createPopularButtonConstraint()
        createTopRatedButtonConstraint()
        createUpComingButtonConstraint()
        createListMoviesTableViewConstraint()
        createMainActivityIndicatorViewConstraint()
    }

    private func setupActiveButton(pressedButton: UIButton) {
        for button in buttons {
            button.backgroundColor = UIColor(named: Constants.systemLightGrayColorName)
            guard button == pressedButton else { continue }
            pressedButton.backgroundColor = UIColor(named: Constants.systemPinkColorName)
        }
    }

    private func fetchData(categoryMovies: String) {
        let urlString =
            "\(Constants.themoviedbQueryText)\(categoryMovies)\(Constants.apiKeyQueryText)" +
            "\(Constants.languageQueryText)\(Constants.pageQueryText)\(Constants.pageQueryText)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                self.decodeData(data: data)
                DispatchQueue.main.async {
                    self.mainActivityIndicatorView.stopAnimating()
                    self.mainActivityIndicatorView.isHidden = true
                    self.listMoviesTableView.reloadData()
                }
            } else {
                guard let safeError = error else { return }
                print(safeError)
            }
        }
        task.resume()
    }

    private func decodeData(data: Data?) {
        let decoder = JSONDecoder()
        guard let safeData = data else { return }
        do {
            let decodedData = try decoder.decode(MovieList.self, from: safeData)
            movies = decodedData.movies
        } catch {
            print(error)
        }
    }

    private func createPopularButtonConstraint() {
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popularButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            popularButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            popularButton.widthAnchor.constraint(equalTo: topRatedButton.widthAnchor),
            popularButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func createTopRatedButtonConstraint() {
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topRatedButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            topRatedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topRatedButton.heightAnchor.constraint(equalToConstant: 40),
            topRatedButton.leftAnchor.constraint(equalTo: popularButton.rightAnchor, constant: 10),
        ])
    }

    private func createUpComingButtonConstraint() {
        upComingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upComingButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            upComingButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            upComingButton.widthAnchor.constraint(equalTo: topRatedButton.widthAnchor),
            upComingButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func createListMoviesTableViewConstraint() {
        listMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listMoviesTableView.topAnchor.constraint(equalTo: topRatedButton.bottomAnchor, constant: 5),
            listMoviesTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            listMoviesTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            listMoviesTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

    private func createMainActivityIndicatorViewConstraint() {
        mainActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainActivityIndicatorView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -30),
            mainActivityIndicatorView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ListMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieTableViewCellText) as? MovieTableViewCell,
            let safeMovies = movies
        else { return UITableViewCell() }
        cell.configureMovieTableViewCell(movie: safeMovies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let safeMovies = movies, indexPath.row < safeMovies.count else { return }
        let currentMovieViewController = CurrentMovieViewController(movie: safeMovies[indexPath.row])
        navigationController?.pushViewController(currentMovieViewController, animated: false)
    }
}
