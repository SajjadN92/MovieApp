//
//  MovieRepository.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

final class MovieRepository: MovieRepositoryProtocol {

    private let remoteDataStore: MovieRemoteDataStoreProtocol

    init(remoteDataStore: MovieRemoteDataStoreProtocol) {
        self.remoteDataStore = remoteDataStore
    }

    func search(_ keyword: String, language: String) async throws -> [Movie] {
        try await remoteDataStore.search(keyword, language: language).results
    }
}
