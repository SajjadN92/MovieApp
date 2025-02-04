//
//  CollectionSampleViewModelProtocol.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine
import UIKit

protocol CollectionSampleViewModelProtocol: BaseViewModel {
    var state: AnyPublisher<CollectionSampleViewModelState, Never> { get }
    func action(_ handler: CollectionSampleViewModelAction)
}

enum CollectionSampleRoute { }

struct CollectionSampleViewModelState {
    let route: CollectionSampleRoute?
    let datasource: NSDiffableDataSourceSnapshot<CollectionSampleView.Section, CollectionSampleView.SectionItem>?

    init(
        route: CollectionSampleRoute? = nil,
        datasource: NSDiffableDataSourceSnapshot<CollectionSampleView.Section, CollectionSampleView.SectionItem>? = nil
    ) {
        self.route = route
        self.datasource = datasource
    }

    func update(
        route: CollectionSampleRoute? = nil,
        datasource: NSDiffableDataSourceSnapshot<CollectionSampleView.Section, CollectionSampleView.SectionItem>?
    ) -> CollectionSampleViewModelState {
        CollectionSampleViewModelState(
            route: route,
            datasource: datasource ?? self.datasource
        )
    }
}

enum CollectionSampleViewModelAction {
    case viewDidLoad
}
