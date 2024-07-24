//
//  StoryboardedView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

protocol StoryboardedView: BaseView {
    init?(
        coder: NSCoder,
        viewModel: ViewModel,
        router: Router
    )
}
