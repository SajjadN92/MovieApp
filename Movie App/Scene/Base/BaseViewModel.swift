//
//  BaseViewModel.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine

protocol BaseViewModel {
    associatedtype State
    associatedtype Action

    var state: AnyPublisher<State, Never> { get }
    func action(_ handler: Action)
}
