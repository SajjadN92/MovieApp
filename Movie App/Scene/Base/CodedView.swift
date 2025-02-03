//
//  CodedView.swift
//  Movie App
//
//  Created by Sajjad on 2/3/25.
//

protocol CodedView: BaseView {
    init(
        viewModel: ViewModel,
        router: Router
    )
}
