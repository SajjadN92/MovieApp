//
//  MovieSearchRouterProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

protocol MovieSearchRouterProtocol: BaseRouter {
    func navigateToDetail(with movie: Movie)
    func navigateToAppSettings()
}
