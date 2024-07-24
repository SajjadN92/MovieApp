//
//  MovieSearch.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

struct MovieSearch: Decodable {
    let page: Int
    let results: [Movie]
}
