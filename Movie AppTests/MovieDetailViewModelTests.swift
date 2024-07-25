//
//  MovieDetailViewModelTests.swift
//  Movie AppTests
//
//  Created by Sajjad on 7/25/24.
//

import XCTest
import Combine
@testable import Movie_App

final class MovieDetailViewModelTests: XCTestCase {

    private enum Constants {
        static let movie = Movie.stub()
        static let timeout = 1.0
    }

    var sut: MovieDetailViewModel!
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        sut = MovieDetailViewModel(movie: Constants.movie)
        cancellables = Set<AnyCancellable>()
    }
}

// MARK: viewDidLoad
extension MovieDetailViewModelTests {

    func test_viewDidLoad_setsData() {
        let expectation = expectation(description: "expect to receive data")
        expectation.expectedFulfillmentCount = 3

        sut.state.compactMap(\.imageURL).sink { imageURL in
            if imageURL == ImageURLGenerator.generateURL(for: Constants.movie.backdropPath!, with: .medium) {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        sut.state.compactMap(\.movieOverview).sink { movieOverview in
            if movieOverview == Constants.movie.overview {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        sut.state.compactMap(\.title).sink { title in
            if title == Constants.movie.title {
                expectation.fulfill()
            }
        }.store(in: &cancellables)

        sut.action(.viewDidLoad)

        wait(for: [expectation], timeout: Constants.timeout)
    }
}
