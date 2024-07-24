//
//  MovieRemoteDataStoreProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

protocol CityLocalDatastoreProtocol {
    func search(_ keyword: String) async throws -> MovieSearch
}
