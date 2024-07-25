//
//  MovieDetailView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class MovieDetailView: StoryboardedViewController<MovieDetailViewModel, MovieDetailRouter> {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieOverviewTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        setupBindings()
        viewModel.action(.viewDidLoad)
    }

    private func configView() {
        view.backgroundColor = .colorBackground
        setupTextView()
        setupImageView()
    }

    private func setupImageView() {
        movieImageView.clipsToBounds = true
        movieImageView.kf.indicatorType = .activity
        movieImageView.contentMode = .scaleAspectFill
    }

    private func setupTextView() {
        movieOverviewTextView.textContainerInset = .zero
        movieOverviewTextView.textContainer.lineFragmentPadding = 0.0
        movieOverviewTextView.contentInset = .zero
        movieOverviewTextView.backgroundColor = .clear
        movieOverviewTextView.isEditable = false
        movieOverviewTextView.text = ""
        movieOverviewTextView.isSelectable = false
        movieOverviewTextView.showsVerticalScrollIndicator = false
        movieOverviewTextView.textColor = .colorText
        movieOverviewTextView.font = Fonts.Body1.medium
    }

    private func setupBindings() {
        viewModel
            .state
            .compactMap(\.title)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.title = title
            }.store(in: &cancellables)

        viewModel
            .state
            .compactMap(\.movieOverview)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] overview in
                self?.movieOverviewTextView.text = overview
            }.store(in: &cancellables)

        viewModel
            .state
            .map(\.imageURL)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] imageURL in
                guard let imageURL else {
                    self?.movieImageView.image = .icPlaceholder
                    return
                }
                self?.movieImageView.kf.setImage(with: imageURL)
            }.store(in: &cancellables)
    }
}
