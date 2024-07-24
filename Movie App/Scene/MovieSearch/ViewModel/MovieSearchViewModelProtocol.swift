//
//  MovieSearchViewModelProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine
import UIKit

protocol MovieSearchViewModelProtocol: BaseViewModel {
    var state: AnyPublisher<MovieSearchViewModelState, Never> { get }
    func action(_ handler: MovieSearchViewModelAction)
}

enum MovieSearchRoute { }

struct MovieSearchViewModelState {
    let route: MovieSearchRoute?

    init(
        route: MovieSearchRoute? = nil
    ) {
        self.route = route
    }

    func update(
        route: MovieSearchRoute? = nil
    ) -> MovieSearchViewModelState {
        MovieSearchViewModelState(
            route: route
        )
    }
}

enum MovieSearchViewModelAction { }
