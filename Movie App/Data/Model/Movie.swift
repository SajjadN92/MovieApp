//
//  Movie.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let releaseDate: String
    let backdrop_path: String
}
