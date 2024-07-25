//
//  MainContext.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

final class MainContext: ContextProtocol {

    lazy var movieRepository: MovieRepositoryProtocol = {
        MovieRepository(remoteDataStore: movieRemoteDataStore)
    }()

    private lazy var movieRemoteDataStore: MovieRemoteDataStoreProtocol = {
        return MovieRemoteDataStore(apiRequest: apiRequest, jsonDecoder: .default)
    }()

    private lazy var apiRequest: APIRequestProtocol = {
        APIRequest(
            config: .defaultConfiguration,
            jsonDecoder: .default
        )
    }()
}
