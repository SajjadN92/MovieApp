//
//  MovieSearchViewModelTests.swift
//  Movie AppTests
//
//  Created by Sajjad on 7/25/24.
//

import XCTest
import Combine
@testable import Movie_App

final class MovieSearchViewModelTests: XCTestCase {

    private enum Constants {
        static let timeout = 1.0
        static let invertTimeout = 0.5
        static let movies = [
            Movie.stub(),
            Movie.stub()
        ]
    }

    var movieRepository: MockMovieRepository!
    var sut: MovieSearchViewModel!
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        movieRepository = TestContext().mockMovieRepository
        movieRepository.error = nil
        movieRepository.movies = Constants.movies
        sut = MovieSearchViewModel(movieRepository: movieRepository)
        cancellables = Set<AnyCancellable>()
    }
}

// MARK: viewDidLoad
extension MovieSearchViewModelTests {

    func test_viewDidLoad_setsThemeToDarkAndLoadingToNotRequested() {
        let expectation = expectation(description: "expect to receive data")
        expectation.expectedFulfillmentCount = 2
        var loadings = [LoadingState<[MovieSearchCellViewModel]>]()
        var themes = [MovieSearchTheme]()
        sut.state.compactMap(\.loadingState).sink { loadingState in
            loadings.append(loadingState)
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.state.compactMap(\.theme).sink { theme in
            themes.append(theme)
            expectation.fulfill()
        }.store(in: &cancellables)

        sut.action(.viewDidLoad)

        wait(for: [expectation], timeout: Constants.timeout)
        XCTAssertEqual(loadings, [.notRequested])
        XCTAssertEqual(themes, [.dark])
    }
}

// MARK: search
extension MovieSearchViewModelTests {

    func test_search_whenKeywordIsEmpty_setsLoadingToNotRequested() {
        let expectation = expectation(description: "expect to receive not requested")
        var loadings = [LoadingState<[MovieSearchCellViewModel]>]()
        sut.state.compactMap(\.loadingState).sink { loadingState in
            loadings.append(loadingState)
            expectation.fulfill()
        }.store(in: &cancellables)

        sut.action(.search(""))

        wait(for: [expectation], timeout: Constants.timeout)
        XCTAssertEqual(loadings, [.notRequested])
    }

    func test_search_whenRepositoryThrowsError_setsLoadingToFailed() {
        let expectation = expectation(description: "expect to receive failed")
        movieRepository.error = TestError.failed
        var loadings = [LoadingState<[MovieSearchCellViewModel]>]()
        sut.state.compactMap(\.loadingState).sink { loadingState in
            loadings.append(loadingState)
            expectation.fulfill()
        }.store(in: &cancellables)

        sut.action(.search("Salam"))

        wait(for: [expectation], timeout: Constants.timeout)
        XCTAssertEqual(loadings, [.failed])
    }

    func test_search_whenMultipleSearchOccuresInLessThanDebounce_theLastOneApplies() async throws {
        let expectation = expectation(description: "expect to receive movies")
        expectation.expectedFulfillmentCount = 2
        expectation.isInverted = true
        var loadings = [LoadingState<[MovieSearchCellViewModel]>]()
        sut.state.compactMap(\.loadingState).sink { loadingState in
            loadings.append(loadingState)
            expectation.fulfill()
        }.store(in: &cancellables)

        sut.action(.search("Salam"))
        try await Task.sleep(for: .milliseconds(100))
        sut.action(.search("Salam2"))

        await fulfillment(of: [expectation], timeout: Constants.invertTimeout)
        XCTAssertEqual(loadings.count, 1)
        if case let .success(movies) = loadings.first {
            XCTAssertEqual(movies.compactMap { $0.id }, Constants.movies.compactMap { $0.id })
        } else {
            XCTFail("Should not reach here")
        }
    }
}


// MARK: itemTapped
extension MovieSearchViewModelTests {

    func test_itemTapped_whenIndexIsNotValid_doesNothing() {
        let expectation = expectation(description: "expect to receive nothing")
        expectation.isInverted = true
        sut.state.compactMap(\.route).sink { route in
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.state.compactMap(\.loadingState).sink { loadingState in
            switch loadingState {
            case .success:
                self.sut.action(.itemTapped(Constants.movies.count))
            default:
                break
            }
        }.store(in: &cancellables)

        sut.action(.search("Salam"))

        wait(for: [expectation], timeout: Constants.invertTimeout)
    }

    func test_itemTapped_whenIndexIsValid_receivesRoute() {
        let expectation = expectation(description: "expect to receive route")
        sut.state.compactMap(\.route).sink { route in
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.state.compactMap(\.loadingState).sink { loadingState in
            switch loadingState {
            case let .success(movies):
                XCTAssertEqual(movies.last?.id, Constants.movies.last?.id)
                self.sut.action(.itemTapped(Constants.movies.count - 1))
            default:
                break
            }
        }.store(in: &cancellables)

        sut.action(.search("Salam"))

        wait(for: [expectation], timeout: Constants.timeout)
    }
}

// MARK: languageButtonTapped
extension MovieSearchViewModelTests {

    func test_languageButtonTapped_changesRoute() {
        let expectation = expectation(description: "expect to receive route")
        var routes = [MovieSearchRoute]()
        sut.state.compactMap(\.route).sink { route in
            routes.append(route)
            switch route {
            case .appSettings:
                expectation.fulfill()
            default:
                break
            }
        }.store(in: &cancellables)

        sut.action(.languageButtonTapped)

        wait(for: [expectation], timeout: Constants.timeout)
        XCTAssertEqual(routes.count, 1)
    }
}

// MARK: themeButtonTapped
extension MovieSearchViewModelTests {

    func test_themeButtonTapped_changesTheme() {
        let expectation = expectation(description: "expect to receive theme")
        expectation.expectedFulfillmentCount = 3
        var routes = [MovieSearchTheme]()
        sut.state.compactMap(\.theme).sink { theme in
            if routes.count < 3 {
                routes.append(theme)
                self.sut.action(.themeButtonTapped)
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        sut.action(.viewDidLoad)

        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(routes, [.dark, .light, .dark])
    }
}
