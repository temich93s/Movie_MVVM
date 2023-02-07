// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - MovieTableViewCell

/// Ячейка с фильмом
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let systemPinkColorName = "SystemPinkColor"
        static let systemWhiteColorName = "SystemWhiteColor"
        static let systemLightGrayColorName = "SystemLightGrayColor"
        static let fatalErrorText = "init(coder:) has not been implemented"
        static let placeholderImageText = "PlaceholderImage"
    }

    // MARK: - Private Visual Properties

    private let nameMovieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(named: Constants.systemWhiteColorName)
        label.backgroundColor = UIColor(named: Constants.systemPinkColorName)
        return label
    }()

    private let descriptionMovieLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 7
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: Constants.systemLightGrayColorName)
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private let dateMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    private let scoreMovieLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: Constants.systemWhiteColorName)
        label.backgroundColor = UIColor(named: Constants.systemPinkColorName)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    private let imageMovieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }

    // MARK: - Public Methods

    func configure(listMoviesViewModel: ListMoviesViewModelProtocol) {
        guard let movie = listMoviesViewModel.movie else { return }
        nameMovieLabel.text = movie.title
        descriptionMovieLabel.text = movie.overview
        dateMovieLabel.text = movie.releaseDate
        scoreMovieLabel.text = "\(movie.voteAverage)"
        imageMovieImageView.image = UIImage(named: Constants.placeholderImageText)
        listMoviesViewModel.fetchData(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.imageMovieImageView.image = UIImage(data: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }

    // MARK: - Private Methods

    private func initView() {
        backgroundColor = UIColor(named: Constants.systemLightGrayColorName)
        selectionStyle = .none
        addSubview()
        setupConstraint()
    }

    private func addSubview() {
        addSubview(nameMovieLabel)
        addSubview(descriptionMovieLabel)
        addSubview(dateMovieLabel)
        addSubview(imageMovieImageView)
        addSubview(scoreMovieLabel)
    }

    private func setupConstraint() {
        createNameMovieLabelConstraint()
        createDescriptionMovieLabelConstraint()
        createDateMovieLabelConstraint()
        createScoreMovieLabelConstraint()
        createImageMovieImageViewConstraint()
    }

    private func createNameMovieLabelConstraint() {
        nameMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameMovieLabel.topAnchor.constraint(equalTo: topAnchor),
            nameMovieLabel.leftAnchor.constraint(equalTo: imageMovieImageView.rightAnchor),
            nameMovieLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nameMovieLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    private func createDescriptionMovieLabelConstraint() {
        descriptionMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionMovieLabel.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor),
            descriptionMovieLabel.leftAnchor.constraint(equalTo: imageMovieImageView.rightAnchor, constant: 5),
            descriptionMovieLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            descriptionMovieLabel.bottomAnchor.constraint(equalTo: dateMovieLabel.topAnchor)
        ])
    }

    private func createDateMovieLabelConstraint() {
        dateMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateMovieLabel.leftAnchor.constraint(equalTo: imageMovieImageView.rightAnchor, constant: 5),
            dateMovieLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            dateMovieLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            dateMovieLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func createScoreMovieLabelConstraint() {
        scoreMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreMovieLabel.topAnchor.constraint(equalTo: imageMovieImageView.topAnchor, constant: 6),
            scoreMovieLabel.leftAnchor.constraint(equalTo: imageMovieImageView.leftAnchor, constant: 6),
            scoreMovieLabel.widthAnchor.constraint(equalToConstant: 33),
            scoreMovieLabel.heightAnchor.constraint(equalToConstant: 33),
        ])
    }

    private func createImageMovieImageViewConstraint() {
        imageMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: topAnchor),
            imageMovieImageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageMovieImageView.widthAnchor.constraint(equalToConstant: 150),
            imageMovieImageView.heightAnchor.constraint(equalToConstant: 200),
            imageMovieImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
