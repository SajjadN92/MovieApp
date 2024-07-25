//
//  MovieDetailRouter.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class MovieDetailRouter: MovieDetailRouterProtocol {

    private let config: MovieDetailModule.Configuration
    weak var viewController: MovieDetailView?

    init(with config: MovieDetailModule.Configuration) {
        self.config = config
    }

}
