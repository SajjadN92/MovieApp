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

enum MovieSearchRoute {
    case movieDetail(Movie)
}

struct MovieSearchViewModelState {
    let route: MovieSearchRoute?
    let loadingState: LoadingState<[MovieSearchCellViewModel]>?

    init(
        route: MovieSearchRoute? = nil,
        loadingState: LoadingState<[MovieSearchCellViewModel]>? = nil
    ) {
        self.route = route
        self.loadingState = loadingState
    }

    func update(
        route: MovieSearchRoute? = nil,
        loadingState: LoadingState<[MovieSearchCellViewModel]>? = nil
    ) -> MovieSearchViewModelState {
        MovieSearchViewModelState(
            route: route,
            loadingState: loadingState
        )
    }
}

enum MovieSearchViewModelAction {
    case viewDidLoad
    case search(String)
    case itemTapped(Int)
}
