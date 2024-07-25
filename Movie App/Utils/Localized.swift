//
//  Localized.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

enum Localized {
    static var search: String { NSLocalizedString("search", comment: "") }
    static var movieSearch: String { NSLocalizedString("movie search", comment: "") }
    static var searchMovie: String { NSLocalizedString("search for some movie", comment: "") }
    static var errorHappened: String { NSLocalizedString("some error happened", comment: "") }
    static var noSearchResult: String { NSLocalizedString("your search has no result", comment: "") }
}
