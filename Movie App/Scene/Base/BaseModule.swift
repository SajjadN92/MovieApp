//
//  BaseModule.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

protocol BaseModule {
    associatedtype SceneView: UIViewController
    associatedtype ConfigurationModel

    static func build(with configuration: ConfigurationModel) -> SceneView
}
