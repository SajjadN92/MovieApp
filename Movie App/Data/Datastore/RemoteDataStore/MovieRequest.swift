//
//  MovieRequest.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

enum MovieRequest: RequestProtocol {

    case search(keyword: String, language: String)

    var path: String {
        return "search/movie"
    }

    var method: RequestMethod {
        switch self {
        case .search:
            return .get
        }
    }

    var requestBody: RequestBody? {
        return nil
    }

    var parameters: RequestParameters? {
        switch self {
        case let .search(keyword, language):
            return [
                "language": language,
                "query": keyword,
                "api_key": apiKey
            ]
        }
    }
}
