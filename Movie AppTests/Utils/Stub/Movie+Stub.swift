//
//  Movie+Stub.swift
//  Movie AppTests
//
//  Created by Sajjad on 7/25/24.
//

import Foundation
@testable import Movie_App

extension Movie {

    static func stub(
        id: Int64 = Int64.random(in:  0...100000),
        title: String = String.random(length: 2),
        releaseDate: String =  String.random(length: 5),
        backdropPath: String = String.random(length: 5),
        overview: String = String.random(length: 5)
    ) -> Movie {
        Movie(id: id, title: title, releaseDate: releaseDate, backdropPath: backdropPath, overview: overview)
    }
}
