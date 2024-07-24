//
//  MoviewRemoteDataStore.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

import Foundation

final class MoviewRemoteDataStore: CityLocalDatastoreProtocol {

    private let apiRequest: APIRequestProtocol
    private let jsonDecoder: JSONDecoder

    init(
        apiRequest: APIRequestProtocol,
        jsonDecoder: JSONDecoder
    ) {
        self.apiRequest = apiRequest
        self.jsonDecoder = jsonDecoder
    }

    func search(_ keyword: String) async throws -> MovieSearch {
        let (data, _) = try await apiRequest.request(api: MovieRequest.search(keyword: keyword))
        return try jsonDecoder.decode(MovieSearch.self, from: data)
    }
}
