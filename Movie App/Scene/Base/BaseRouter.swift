//
//  BaseRouter.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

protocol BaseRouter {
    associatedtype ViewController
    associatedtype ConfigurationModel

    var viewController: ViewController { get set }
    init(with config: ConfigurationModel)
}
