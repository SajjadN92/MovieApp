//
//  MovieSearchRouter.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class MovieSearchRouter: MovieSearchRouterProtocol {

    private let config: MovieSearchModule.Configuration
    weak var viewController: MovieSearchView?

    init(with config: MovieSearchModule.Configuration) {
        self.config = config
    }

    func navigateToDetail(with movie: Movie) {
        let vc = MovieDetailModule.build(with: MovieDetailModule.Configuration(context: config.context, movie: movie))
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
