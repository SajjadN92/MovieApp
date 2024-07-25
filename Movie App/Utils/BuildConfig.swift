//
//  BuildConfig.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

enum BuildConfig {

    static var apiBaseURL: String {
        value(for: "API_BASE_URL")
    }

    static var apiKey: String {
        value(for: "API_KEY")
    }

    static var imageBaseURL: String {
        value(for: "IMAGE_BASE_URL")
    }

    private static func value(for key: String) -> String {
        guard let value = Bundle.app.object(forInfoDictionaryKey: key) as? String else {
            fatalError("value not found for key: \(key)")
        }
        return value
    }
}
