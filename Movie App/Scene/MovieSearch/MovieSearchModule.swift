//
//  MovieSearchModule.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

enum MovieSearchModule: BaseModule {

    struct Configuration {
        let context: ContextProtocol
    }

    static func build(with configuration: Configuration) -> MovieSearchView {
        let viewModel = MovieSearchViewModel()
        let router = MovieSearchRouter(with: configuration)
        let viewController = MovieSearchView.instantiateViewController { coder in
            return MovieSearchView(coder: coder, viewModel: viewModel, router: router)
        }

        router.viewController = viewController
        return viewController
    }
}
