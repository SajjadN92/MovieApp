//
//  LoadingState.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Foundation

enum LoadingState<T: Equatable> {
    case notRequested
    case isLoading
    case failed
    case success(T)

    var isLoading: Bool {
        switch self {
        case .isLoading:
            return true
        default:
            return false
        }
    }
}

extension LoadingState: Equatable { }
