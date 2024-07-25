//
//  TestContext.swift
//  Movie AppTests
//
//  Created by Sajjad on 7/25/24.
//

import Foundation
@testable import Movie_App

final class TestContext: ContextProtocol {
    lazy var movieRepository: any MovieRepositoryProtocol = {
        return MockMovieRepository()
    }()

    var mockMovieRepository: MockMovieRepository {
        return movieRepository as! MockMovieRepository
    }
}
