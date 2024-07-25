//
//  MovieSearchView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class MovieSearchView: StoryboardedViewController<MovieSearchViewModel, MovieSearchRouter> {

    @IBOutlet weak var searchView: SearchView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        setupBindings()
    }

    private func configView() { 
        view.backgroundColor = .colorBackground
        setupNavigation()
        searchView.textPublisher.sink { [weak self] text in
            self?.viewModel.action(.search(text))
        }.store(in: &cancellables)
    }

    private func setupNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .colorSecondaryBackground
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.colorText,
            .font: Fonts.Title1.bold
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Localized.movieSearch
    }

    private func setupBindings() { }
}
