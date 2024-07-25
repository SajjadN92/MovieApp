//
//  MovieDetailViewModel.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine
import Foundation

final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    let movie: Movie
    private var _state: CurrentValueSubject<MovieDetailViewModelState, Never>
    var state: AnyPublisher<MovieDetailViewModelState, Never> {
        _state.eraseToAnyPublisher()
    }

    init(movie: Movie) {
        self.movie = movie
        self._state = CurrentValueSubject<MovieDetailViewModelState, Never>(
            MovieDetailViewModelState()
        )
    }

    func action(_ handler: MovieDetailViewModelAction) {
        switch handler {
        case .viewDidLoad:
            var imageURL: URL? {
                if let imageName = movie.backdropPath {
                    return ImageURLGenerator.generateURL(for: imageName, with: .medium)
                } else {
                    return nil
                }
            }
            _state.value = _state.value.update(
                title: movie.title,
                imageURL: imageURL,
                movieOverview: movie.overview
            )
        }
    }
}
