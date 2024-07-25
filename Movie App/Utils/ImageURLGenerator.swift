//
//  ImageURLGenerator.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

class ImageURLGenerator {

    enum ImageSize {
        case small
        case medium

        var size: String {
            switch self {
            case .small:
                return "w300"
            case .medium:
                return "w500"
            }
        }
    }

    static func generateURL(for imageName: String, with size: ImageSize) -> URL? {
        return URL(string: "\(BuildConfig.imageBaseURL)/\(size.size)/\(imageName)")
    }
}
