//
//  BaseView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

protocol BaseView {
    associatedtype Router
    associatedtype ViewModel

    var router: Router { get set }
    var viewModel: ViewModel { get set }
}
