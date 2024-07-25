//
//  MovieSearchViewModel.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine
import Foundation

final class MovieSearchViewModel: MovieSearchViewModelProtocol {

    private enum Constants {
        static let searchDebounce = 0.4
    }

    private var movieRepository: MovieRepositoryProtocol
    private var searchTask: Task<Void, Never>?
    private var movies = [Movie]()
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
        switch handler {
        case .viewDidLoad:
            _state.value = _state.value.update(loadingState: .notRequested)
        case let .search(keyword):
            search(keyword: keyword)
        case let .itemTapped(index):
            _state.value = _state.value.update(route: .movieDetail(movies[index]))
        }
    }

    private func search(keyword: String) {
        searchTask?.cancel()

        guard !keyword.isEmpty else {
            return _state.value = _state.value.update(loadingState: .notRequested)
        }

        searchTask = Task(priority: .medium) {
            do {
                try await Task.sleep(for: .seconds(Constants.searchDebounce))
                try Task.checkCancellation()
                movies = try await movieRepository.search(keyword)
                _state.value = _state.value.update(loadingState: .success(movies.compactMap { movie in
                    var url: URL? {
                        if let imageName = movie.backdropPath {
                            return ImageURLGenerator.generateURL(for: imageName, with: .small)
                        } else {
                            return nil
                        }
                    }
                    return MovieSearchCellViewModel(
                        id: movie.id,
                        movieTitle: movie.title,
                        movieDate: movie.releaseDate,
                        imageURL: url
                    )
                }))
            } catch let error as CancellationError {
            } catch {
                _state.value = _state.value.update(loadingState: .failed)
            }
        }
    }

}
