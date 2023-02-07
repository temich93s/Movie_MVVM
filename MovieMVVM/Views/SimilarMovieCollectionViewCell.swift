// SimilarMovieCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - SimilarMovieCollectionViewCell

/// Ячейка с похожим фильмом
final class SimilarMovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    private enum Constants {
        static let fatalErrorText = "init(coder:) has not been implemented"
    }

    // MARK: - Private Visual Properties

    private let imageMovieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        initView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }

    // MARK: - Public Methods

    func configure(detailMovieViewModel: DetailMovieViewModelProtocol) {
        detailMovieViewModel.setupSimilarPosterCompetion { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.imageMovieImageView.image = UIImage(data: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        detailMovieViewModel.fetchSimilarPosterData()
    }

    // MARK: - Private Methods

    private func initView() {
        contentView.addSubview(imageMovieImageView)
        createImageMovieImageViewConstraint()
    }

    private func createImageMovieImageViewConstraint() {
        imageMovieImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageMovieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageMovieImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageMovieImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageMovieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
