//
//  MockMovieRepository.swift
//  Movie AppTests
//
//  Created by Sajjad on 7/25/24.
//

import Foundation
@testable import Movie_App

final class MockMovieRepository: MovieRepositoryProtocol {

    var error: TestError?
    var movies = [Movie]()

    func search(_ keyword: String, language: String) async throws -> [Movie] {
        if let error {
            throw error
        } else {
            return movies
        }
    }
}
