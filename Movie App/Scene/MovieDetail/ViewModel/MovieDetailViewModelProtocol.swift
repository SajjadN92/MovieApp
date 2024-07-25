//
//  MovieDetailViewModelProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine
import UIKit

protocol MovieDetailViewModelProtocol: BaseViewModel {
    var state: AnyPublisher<MovieDetailViewModelState, Never> { get }
    func action(_ handler: MovieDetailViewModelAction)
}

enum MovieDetailRoute { }

struct MovieDetailViewModelState {
    let route: MovieDetailRoute?
    let title: String?
    let imageURL: URL?
    let movieOverview: String?

    init(
        route: MovieDetailRoute? = nil,
        title: String? = nil,
        imageURL: URL? = nil,
        movieOverview: String? = nil
    ) {
        self.route = route
        self.title = title
        self.imageURL = imageURL
        self.movieOverview = movieOverview
    }

    func update(
        route: MovieDetailRoute? = nil,
        title: String? = nil,
        imageURL: URL? = nil,
        movieOverview: String? = nil
    ) -> MovieDetailViewModelState {
        MovieDetailViewModelState(
            route: route,
            title: title,
            imageURL: imageURL,
            movieOverview: movieOverview
        )
    }
}

enum MovieDetailViewModelAction {
    case viewDidLoad
}
