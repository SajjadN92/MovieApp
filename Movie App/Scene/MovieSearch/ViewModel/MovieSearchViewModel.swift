//
//  MovieSearchViewModel.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine

final class MovieSearchViewModel: MovieSearchViewModelProtocol {

    private var movieRepository: MovieRepositoryProtocol
    private var _state: CurrentValueSubject<MovieSearchViewModelState, Never>
    var state: AnyPublisher<MovieSearchViewModelState, Never> {
        _state.eraseToAnyPublisher()
    }

    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
        self._state = CurrentValueSubject<MovieSearchViewModelState, Never>(
            MovieSearchViewModelState()
        )
    }

    func action(_ handler: MovieSearchViewModelAction) {
        
    }
}
