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

    func configureSimilarMovieCollectionViewCell(dataImage: Data) {
        imageMovieImageView.image = UIImage(data: dataImage)
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
