//
//  MovieRepositoryProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

protocol MovieRepositoryProtocol {
    func search(_ keyword: String, language: String) async throws -> [Movie]
}
