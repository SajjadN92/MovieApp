//
//  APIRequest.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

final class APIRequest: APIRequestProtocol {

    enum Constants {
        static let cookieName = "__Host-session"
    }

    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder

    init(
        config: URLSessionConfiguration,
        jsonDecoder: JSONDecoder
    ) {
        self.urlSession = URLSession(configuration: config)
        self.jsonDecoder = jsonDecoder
    }

    func request(api: RequestProtocol, retryCount: Int) async throws -> (Data, URLResponse) {
        for retryIndex in 0 ..< retryCount {
            guard let apiRequest = api.urlRequest() else {
                throw APIError.badRequest
            }

            try Task.checkCancellation()
            do {
                let (data, response) = try await urlSession.data(for: apiRequest)

                if await api.retryHandler(response: response) {
                    try await Task.sleep(nanoseconds: api.retryDelay)
                    continue
                } else {
                    return try api.verifyResponse(data: data, response: response, with: jsonDecoder)
                }
            } catch where retryIndex < retryCount - 1 {
                try await Task.sleep(nanoseconds: api.retryDelay)
                continue
            } catch {
                throw error
            }
        }
        throw APIError.unknown
    }
}

extension URLSessionConfiguration {
    class var defaultConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.shouldUseExtendedBackgroundIdleMode = true
        configuration.waitsForConnectivity = false
        configuration.isDiscretionary = false
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.timeoutIntervalForRequest = 30.0
        configuration.timeoutIntervalForResource = 30.0
        return configuration
    }
}
