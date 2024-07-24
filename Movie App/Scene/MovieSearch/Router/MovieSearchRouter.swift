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

}
