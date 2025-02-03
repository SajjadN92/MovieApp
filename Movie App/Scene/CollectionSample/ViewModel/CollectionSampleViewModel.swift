//
//  CollectionSampleViewModel.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import Combine
import Foundation
import UIKit

final class CollectionSampleViewModel: CollectionSampleViewModelProtocol {

    private var _state: CurrentValueSubject<CollectionSampleViewModelState, Never>
    var state: AnyPublisher<CollectionSampleViewModelState, Never> {
        _state.eraseToAnyPublisher()
    }

    init() {
        self._state = CurrentValueSubject<CollectionSampleViewModelState, Never>(
            CollectionSampleViewModelState()
        )
    }

    func action(_ handler: CollectionSampleViewModelAction) {
        switch handler {
        case .viewDidLoad:
            setupDatasource()
        }
    }

    private func setupDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionSampleView.Section, CollectionSampleView.SectionItem>()

        let section1 = CollectionSampleView.Section.thumbnail(model: CollectionSampleHeaderViewModel(id: UUID().uuidString, headerType: .header(title: "Section 1 Header")))
        snapshot.appendSections([section1])
        snapshot.appendItems(
            [
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBlue))
            ],
            toSection: section1
        )

        let section2 = CollectionSampleView.Section.thumbplay(model: CollectionSampleHeaderViewModel(id: UUID().uuidString, headerType: .none))
        snapshot.appendSections([section2])
        snapshot.appendItems(
            [
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemRed))
            ],
            toSection: section2
        )

        let section3 = CollectionSampleView.Section.theater(model: CollectionSampleHeaderViewModel(id: UUID().uuidString, headerType: .header(title: "Section 3 Header")))
        snapshot.appendSections([section3])
        snapshot.appendItems(
            [
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemMint))
            ],
            toSection: section3
        )

        let section4 = CollectionSampleView.Section.thumbplay(model: CollectionSampleHeaderViewModel(id: UUID().uuidString, headerType: .none))
        snapshot.appendSections([section4])
        snapshot.appendItems(
            [
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink)),
                CollectionSampleView.SectionItem.thumbplay(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemPink))
            ],
            toSection: section4
        )

        let section5 = CollectionSampleView.Section.theater(model: CollectionSampleHeaderViewModel(id: UUID().uuidString, headerType: .none))
        snapshot.appendSections([section5])
        snapshot.appendItems(
            [
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown)),
                CollectionSampleView.SectionItem.theater(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemBrown))
            ],
            toSection: section5
        )

        let section6 = CollectionSampleView.Section.thumbnail(model: CollectionSampleHeaderViewModel(id: UUID().uuidString, headerType: .header(title: "Section 6 Header")))
        snapshot.appendSections([section6])
        snapshot.appendItems(
            [
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemYellow))
            ],
            toSection: section6
        )

        let section7 = CollectionSampleView.Section.verticalThumbnail(model: CollectionSampleHeaderViewModel(id: UUID().uuidString, headerType: .header(title: "Section 7 Header")))
        snapshot.appendSections([section7])
        snapshot.appendItems(
            [
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal)),
                CollectionSampleView.SectionItem.thumbnail(model: CollectionSampleCellViewModel(id: UUID().uuidString, color: .systemTeal))
            ],
            toSection: section7
        )

        _state.value = _state.value.update(datasource: snapshot)
    }
}
