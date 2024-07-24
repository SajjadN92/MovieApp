//
//  JSONDecoder+Default.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

extension JSONDecoder {

    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
