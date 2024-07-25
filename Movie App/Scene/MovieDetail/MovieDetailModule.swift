//
//  MovieDetailModule.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

enum MovieDetailModule: BaseModule {

    struct Configuration {
        let context: ContextProtocol
        let movie: Movie
    }

    static func build(with configuration: Configuration) -> MovieDetailView {
        let viewModel = MovieDetailViewModel(movie: configuration.movie)
        let router = MovieDetailRouter(with: configuration)
        let viewController = MovieDetailView.instantiateViewController { coder in
            return MovieDetailView(coder: coder, viewModel: viewModel, router: router)
        }

        router.viewController = viewController
        return viewController
    }
}
