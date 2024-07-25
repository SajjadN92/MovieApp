//
//  MovieSearchCell.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit
import Kingfisher

final class MovieSearchCell: UICollectionViewCell {

    private enum Constants {
        static let cornerRadius = 12.0
    }

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        backgroundColor = .colorSecondaryBackground
        setupTitleLabel()
        setupDateLabel()
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.kf.indicatorType = .activity
    }

    private func setupTitleLabel() {
        movieTitleLabel.textColor = .colorText
        movieTitleLabel.font = Fonts.Body1.medium
    }

    private func setupDateLabel() {
        movieDateLabel.textColor = .colorSecondaryText
        movieDateLabel.font = Fonts.Body2.medium
    }

    func config(with model: MovieSearchCellViewModel) {
        movieTitleLabel.text = model.movieTitle
        movieDateLabel.text = model.movieDate

        if let url = model.imageURL {
            movieImageView.kf.setImage(with: url)
        } else {
            movieImageView.image = .icPlaceholder
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        movieImageView.kf.cancelDownloadTask()
    }
}
