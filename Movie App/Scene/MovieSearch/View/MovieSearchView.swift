//
//  MovieSearchView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class MovieSearchView: StoryboardedViewController<MovieSearchViewModel, MovieSearchRouter> {

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        setupBindings()
    }

    private func configView() { 
        view.backgroundColor = .colorBackground
    }

    private func setupBindings() { }
}
