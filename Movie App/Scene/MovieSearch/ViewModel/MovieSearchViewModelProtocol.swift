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

enum MovieSearchTheme {
    case light
    case dark

    var icon: String {
        switch self {
        case .light:
            return "moon.fill"
        case .dark:
            return "sun.max"
        }
    }

    var style: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

enum MovieSearchRoute {
    case movieDetail(Movie)
    case appSettings
}

struct MovieSearchViewModelState {
    let route: MovieSearchRoute?
    let loadingState: LoadingState<[MovieSearchCellViewModel]>?
    let theme: MovieSearchTheme?

    init(
        route: MovieSearchRoute? = nil,
        loadingState: LoadingState<[MovieSearchCellViewModel]>? = nil,
        theme: MovieSearchTheme? = nil
    ) {
        self.route = route
        self.loadingState = loadingState
        self.theme = theme
    }

    func update(
        route: MovieSearchRoute? = nil,
        loadingState: LoadingState<[MovieSearchCellViewModel]>? = nil,
        theme: MovieSearchTheme? = nil
    ) -> MovieSearchViewModelState {
        MovieSearchViewModelState(
            route: route,
            loadingState: loadingState,
            theme: theme ?? self.theme
        )
    }
}

enum MovieSearchViewModelAction {
    case viewDidLoad
    case search(String)
    case itemTapped(Int)
    case themeButtonTapped
    case languageButtonTapped
}
