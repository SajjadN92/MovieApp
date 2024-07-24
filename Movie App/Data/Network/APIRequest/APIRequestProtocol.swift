//
//  APIRequestProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

protocol APIRequestProtocol {
    func request(api: RequestProtocol, retryCount: Int) async throws -> (Data, URLResponse)
}

extension APIRequestProtocol {
    func request(api: RequestProtocol) async throws -> (Data, URLResponse) {
        try await request(api: api, retryCount: api.retryCount)
    }
}
