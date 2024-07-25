//
//  MovieSearchCellViewModel.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

struct MovieSearchCellViewModel: Hashable {
    let id: Int64
    let movieTitle: String
    let movieDate: String
    let imageURL: URL?
}
