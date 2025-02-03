//
//  CollectionSampleModule.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

enum CollectionSampleModule: BaseModule {

    struct Configuration {
        let context: ContextProtocol
    }

    static func build(with configuration: Configuration) -> CollectionSampleView {
        let viewModel = CollectionSampleViewModel()
        let router = CollectionSampleRouter(with: configuration)
        let viewController = CollectionSampleView(viewModel: viewModel, router: router)
        router.viewController = viewController
        return viewController
    }
}
