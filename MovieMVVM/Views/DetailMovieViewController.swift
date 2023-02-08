// DetailMovieViewController.swift
// Copyright © SolovevAA. All rights reserved.

import UIKit

// MARK: - CurrentMovieViewController

/// Экран с выбранным фильмом
final class DetailMovieViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let apiTitleText = "Ключ API"
        static let apiMessageText = "Введите ключ API"
        static let overviewText = "Overview"
        static let systemPinkColorName = "SystemPinkColor"
        static let releaseDataLabelText = "Релиз:"
        static let voteAverageLabelText = "Оценка:"
        static let voteCountLabelText = "Голоса:"
        static let similarMovieLabelText = "Похожие фильмы"
        static let similarMovieCollectionViewCellText = "SimilarMovieCollectionViewCell"
        static let fatalErrorText = "init(coder:) has not been implemented"
        static let errorText = "Error"
        static let okText = "OK"
        static let heightCoefficientNumber: CGFloat = 2 / 3
        static let twoNumber = 2
    }

    // MARK: - Private Visual Properties

    private let imageMovieImageView = UIImageView()

    private let mainActivityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = UIColor(named: Constants.systemPinkColorName)
        activity.startAnimating()
        return activity
    }()

    private let titleMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: Constants.systemPinkColorName)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()

    private let releaseDataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = Constants.releaseDataLabelText
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let releaseDataValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = Constants.voteAverageLabelText
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteAverageValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = Constants.voteCountLabelText
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let voteCountValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private let overviewMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let similarMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = Constants.similarMovieLabelText
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()

    private let similarMovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            SimilarMovieCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.similarMovieCollectionViewCellText
        )
        return collectionView
    }()

    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView = UIView()

    // MARK: - Private Properties

    private var detailMovieViewModel: DetailMovieViewModel
    private lazy var heightSimilarMovieCollectionView = similarMovieCollectionView.heightAnchor
        .constraint(equalToConstant: 0)

    // MARK: - Initializers

    init(detailMovieViewModel: DetailMovieViewModel) {
        self.detailMovieViewModel = detailMovieViewModel
        super.init(nibName: nil, bundle: nil)
        initView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func initView() {
        detailMovieViewModel.uploadApiKeyCompletion = { [weak self] in
            guard let self = self else { return }
            self.showAlert(
                title: Constants.apiTitleText,
                message: Constants.apiMessageText,
                actionTitle: Constants.okText
            ) { key in
                self.detailMovieViewModel.uploadApiKey(key)
            }
        }
        detailMovieViewModel.checkApiKey()
        detailMovieViewModel.mainPosterCompletion = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.imageMovieImageView.image = UIImage(data: data)
            case let .failure(error):
                self.showErrorAlert(
                    alertTitle: Constants.errorText,
                    message: error.localizedDescription,
                    actionTitle: Constants.okText
                )
            }
        }
        detailMovieViewModel.fetchMainPosterData()
        titleMovieLabel.text = detailMovieViewModel.movie.title
        releaseDataValueLabel.text = detailMovieViewModel.movie.releaseDate
        voteAverageValueLabel.text = "\(detailMovieViewModel.movie.voteAverage)"
        voteCountValueLabel.text = "\(detailMovieViewModel.movie.voteCount)"
        overviewMovieLabel.text = detailMovieViewModel.movie.overview
        setupSimilarMovies()
    }

    private func setupView() {
        title = Constants.overviewText
        similarMovieCollectionView.delegate = self
        similarMovieCollectionView.dataSource = self
        mainActivityIndicatorView.startAnimating()
        mainActivityIndicatorView.isHidden = false
        navigationController?.navigationBar.tintColor = UIColor(named: Constants.systemPinkColorName)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareImageAction)
        )
        addSubview()
        setupConstraint()
    }

    private func addSubview() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(imageMovieImageView)
        contentView.addSubview(titleMovieLabel)
        contentView.addSubview(releaseDataLabel)
        contentView.addSubview(releaseDataValueLabel)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(voteAverageValueLabel)
        contentView.addSubview(voteCountLabel)
        contentView.addSubview(voteCountValueLabel)
        contentView.addSubview(overviewMovieLabel)
        contentView.addSubview(similarMovieLabel)
        contentView.addSubview(similarMovieCollectionView)
        contentView.addSubview(mainActivityIndicatorView)
    }

    private func setupConstraint() {
        createImageMovieImageViewConstraint()
        createTitleMovieLabelConstraint()
        createReleaseDataLabelConstraint()
        createReleaseDataValueLabelConstraint()
        createVoteAverageLabelConstraint()
        createVoteAverageValueLabelConstraint()
        createVoteCountLabelConstraint()
        createVoteCountValueLabelConstraint()
        createOverviewMovieLabelConstraint()
        createSimilarMovieLabelConstraint()
        createSimilarMovieCollectionViewConstraint()
        createMainScrollViewConstraint()
        createContentViewConstraint()
        createMainActivityIndicatorViewConstraint()
    }

    @objc private func shareImageAction() {
        startItemSharing(item: imageMovieImageView.image)
    }

    private func startItemSharing(item: Any?) {
        guard let saveItem = item else { return }
        let safeActivityVC = UIActivityViewController(
            activityItems: [saveItem],
            applicationActivities: nil
        )
        present(safeActivityVC, animated: true, completion: nil)
    }

    private func setupSimilarMovies() {
        detailMovieViewModel.similarMoviesCompletion = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.similarMovieCollectionView.reloadData()
            case let .failure(error):
                self.showErrorAlert(
                    alertTitle: Constants.errorText,
                    message: error.localizedDescription,
                    actionTitle: Constants.okText
                )
            }
        }
        detailMovieViewModel.fetchSimilarMovies()
    }

    private func createImageMovieImageViewConstraint() {
        imageMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageMovieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMovieImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageMovieImageView.heightAnchor.constraint(equalTo: imageMovieImageView.widthAnchor, multiplier: 1.5)
        ])
    }

    private func createTitleMovieLabelConstraint() {
        titleMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleMovieLabel.topAnchor.constraint(equalTo: imageMovieImageView.bottomAnchor, constant: 20),
            titleMovieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleMovieLabel.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func createReleaseDataLabelConstraint() {
        releaseDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            releaseDataLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 20),
            releaseDataLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            releaseDataLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }

    private func createReleaseDataValueLabelConstraint() {
        releaseDataValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            releaseDataValueLabel.topAnchor.constraint(equalTo: titleMovieLabel.bottomAnchor, constant: 20),
            releaseDataValueLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            releaseDataValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func createVoteAverageLabelConstraint() {
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteAverageLabel.topAnchor.constraint(equalTo: releaseDataLabel.bottomAnchor, constant: 10),
            voteAverageLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            voteAverageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }

    private func createVoteAverageValueLabelConstraint() {
        voteAverageValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteAverageValueLabel.topAnchor.constraint(equalTo: releaseDataLabel.bottomAnchor, constant: 10),
            voteAverageValueLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            voteAverageValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func createVoteCountLabelConstraint() {
        voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteCountLabel.topAnchor.constraint(equalTo: voteAverageValueLabel.bottomAnchor, constant: 10),
            voteCountLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            voteCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }

    private func createVoteCountValueLabelConstraint() {
        voteCountValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voteCountValueLabel.topAnchor.constraint(equalTo: voteAverageValueLabel.bottomAnchor, constant: 10),
            voteCountValueLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            voteCountValueLabel.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func createOverviewMovieLabelConstraint() {
        overviewMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overviewMovieLabel.topAnchor.constraint(equalTo: voteCountLabel.bottomAnchor, constant: 20),
            overviewMovieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overviewMovieLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }

    private func createSimilarMovieLabelConstraint() {
        similarMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            similarMovieLabel.topAnchor.constraint(equalTo: overviewMovieLabel.bottomAnchor, constant: 20),
            similarMovieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func createMainActivityIndicatorViewConstraint() {
        mainActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainActivityIndicatorView.centerYAnchor.constraint(equalTo: similarMovieLabel.centerYAnchor),
            mainActivityIndicatorView.leftAnchor.constraint(equalTo: similarMovieLabel.rightAnchor, constant: 10)
        ])
    }

    private func createSimilarMovieCollectionViewConstraint() {
        similarMovieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            similarMovieCollectionView.topAnchor.constraint(equalTo: similarMovieLabel.bottomAnchor, constant: 20),
            similarMovieCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            similarMovieCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            similarMovieCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func createContentViewConstraint() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor)
        ])
    }

    private func createMainScrollViewConstraint() {
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if detailMovieViewModel.similarMovies.count != 0 {
            mainActivityIndicatorView.stopAnimating()
            mainActivityIndicatorView.isHidden = true
        }
        heightSimilarMovieCollectionView.constant =
            similarMovieCollectionView.frame.width * Constants.heightCoefficientNumber *
            CGFloat(detailMovieViewModel.similarMovies.count / Constants.twoNumber)
        heightSimilarMovieCollectionView.isActive = true
        return detailMovieViewModel.similarMovies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.similarMovieCollectionViewCellText,
                for: indexPath
            ) as? SimilarMovieCollectionViewCell,
            indexPath.row < detailMovieViewModel.similarMovies.count
        else { return UICollectionViewCell() }
        detailMovieViewModel.setupPoster(index: indexPath.row)
        cell.configure(detailMovieViewModel: detailMovieViewModel)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: (collectionView.frame.width) / 2, height: (collectionView.frame.width) / 1.5)
    }
}
