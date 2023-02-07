// ListMoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - ListMoviesViewController

/// Экран со списком фильмов
final class ListMoviesViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let systemPinkColorName = "SystemPinkColor"
        static let systemLightGrayColorName = "SystemLightGrayColor"
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

    // MARK: - Public Properties

    var listMoviesViewModel: ListMoviesViewModelProtocol
    var onFinishFlow: (() -> ())?
    var toDetailMovie: ((Movie) -> ())?

    // MARK: - Private Properties

    private lazy var buttons: [UIButton] = [popularButton, topRatedButton, upComingButton]
    private lazy var completion: ((Result<[Movie], Error>) -> Void) = { [weak self] result in
        guard let self = self else { return }
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.mainActivityIndicatorView.stopAnimating()
                self.mainActivityIndicatorView.isHidden = true
                self.listMoviesTableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Initializers

    init(listMovieViewModel: ListMoviesViewModel) {
        listMoviesViewModel = listMovieViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    @objc private func catedoryButtonAction(sender: UIButton) {
        mainActivityIndicatorView.startAnimating()
        mainActivityIndicatorView.isHidden = false
        setupActiveButton(pressedButton: sender)
        switch sender.tag {
        case 0:
            listMoviesViewModel.currentCategoryMovies = .popular
            listMoviesViewModel.fetchMovies(completion: completion)
        case 1:
            listMoviesViewModel.currentCategoryMovies = .topRated
            listMoviesViewModel.fetchMovies(completion: completion)
        case 2:
            listMoviesViewModel.currentCategoryMovies = .upcoming
            listMoviesViewModel.fetchMovies(completion: completion)
        default:
            break
        }
    }

    @objc private func refreshAction() {
        listMoviesViewModel.fetchMovies(completion: completion)
        refreshControl.endRefreshing()
    }

    private func setupView() {
        title = Constants.moviesText
        listMoviesTableView.delegate = self
        listMoviesTableView.dataSource = self
        listMoviesTableView.addSubview(refreshControl)
        addSubview()
        setupConstraint()
        setupRefreshControl()
        listMoviesViewModel.fetchMovies(completion: completion)
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
        listMoviesViewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieTableViewCellText) as? MovieTableViewCell
        else { return UITableViewCell() }
        listMoviesViewModel.setupMovie(index: indexPath.row)
        cell.configure(listMoviesViewModel: listMoviesViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < listMoviesViewModel.movies.count, let toDetailMovie = toDetailMovie else { return }
        toDetailMovie(listMoviesViewModel.movies[indexPath.row])
    }
}
