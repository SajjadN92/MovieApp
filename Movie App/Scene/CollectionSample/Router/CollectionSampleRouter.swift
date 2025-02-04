//
//  CollectionSampleRouter.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class CollectionSampleRouter: CollectionSampleRouterProtocol {

    private let config: CollectionSampleModule.Configuration
    weak var viewController: CollectionSampleView?

    init(with config: CollectionSampleModule.Configuration) {
        self.config = config
    }

}
