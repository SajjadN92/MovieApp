//
//  StoryboardedViewController.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit
import Combine

class StoryboardedViewController<T: BaseViewModel, U: BaseRouter>: UIViewController, StoryboardedView {
    var viewModel: T
    var router: U
    var cancellables = Set<AnyCancellable>()

    required init?(coder: NSCoder, viewModel: T, router: U) {
        self.viewModel = viewModel
        self.router = router
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
