//
//  Movie.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

struct Movie: Decodable {
    let id: Int64
    let title: String
    let releaseDate: String
    let backdropPath: String?
}
