//
//  CodedViewController.swift
//  Movie App
//
//  Created by Sajjad on 2/3/25.
//

import UIKit
import Combine

class CodedViewController<T: BaseViewModel, U: BaseRouter>: UIViewController, CodedView {
    var viewModel: T
    var router: U
    var cancellables = Set<AnyCancellable>()

    required init(viewModel: T, router: U) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
