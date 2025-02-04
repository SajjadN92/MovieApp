//
//  CollectionSampleView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class CollectionSampleView: CodedViewController<CollectionSampleViewModel, CollectionSampleRouter> {
    private enum Constants {
        static let itemSpace = 8.0
        static let edgeSpace = 16.0
    }

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .colorBackground
        return cv
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem>?

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        setupBindings()
        viewModel.action(.viewDidLoad)
    }

    private func configView() {
        view.backgroundColor = .colorBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.collectionViewLayout = generateLayout()
        dataSource = makeDataSource()
        collectionView.dataSource = dataSource
    }

    private func setupBindings() {
        viewModel.state
            .compactMap(\.datasource)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshot in
                self?.dataSource?.apply(snapshot)
            }.store(in: &cancellables)
    }
}

extension CollectionSampleView {

    private func makeCellRegistration() {
        collectionView.registerCellType(CollectionSampleCell.self)
        collectionView.registerSupplementaryViewType(CollectionSampleHeader.self)
    }

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionIdentifier = self?.dataSource?.sectionIdentifier(for: sectionIndex) else {
                return nil
            }
            switch sectionIdentifier {
            case .thumbnail(let model):
                return self?.generateThumbnailLayout(env: env, hasHeader: model.headerType != .none)
            case .verticalThumbnail(let model):
                return self?.generateVerticalThumbnailLayout(env: env, hasHeader: model.headerType != .none)
            case .thumbplay(let model):
                return self?.generateThumbplayLayout(env: env, hasHeader: model.headerType != .none)
            case .theater(let model):
                return self?.generateTheaterLayout(env: env, hasHeader: model.headerType != .none)
            }
        }
        return layout
    }

    private func generateVerticalThumbnailLayout(env: NSCollectionLayoutEnvironment, hasHeader: Bool) -> NSCollectionLayoutSection {
        let groupWidth = env.container.contentSize.width - Constants.edgeSpace * 2
        let itemWidth = (groupWidth - Constants.itemSpace) / 2
        let height = itemWidth * 1.5

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemWidth),
            heightDimension: .absolute(height)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .absolute(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: itemLayout, count: 2)
        group.interItemSpacing = .fixed(Constants.itemSpace)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.itemSpace
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.edgeSpace / 2,
            leading: Constants.edgeSpace,
            bottom: Constants.edgeSpace / 2,
            trailing: Constants.edgeSpace
        )

        if hasHeader {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(55.0)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    private func generateThumbnailLayout(env: NSCollectionLayoutEnvironment, hasHeader: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(130),
            heightDimension: .absolute(200)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(130),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.itemSpace
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.edgeSpace / 2,
            leading: Constants.edgeSpace,
            bottom: Constants.edgeSpace / 2,
            trailing: Constants.edgeSpace
        )

        if hasHeader {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(55.0)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    private func generateThumbplayLayout(env: NSCollectionLayoutEnvironment, hasHeader: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(200),
            heightDimension: .absolute(130)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(200),
            heightDimension: .absolute(130)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.itemSpace
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.edgeSpace / 2,
            leading: Constants.edgeSpace,
            bottom: Constants.edgeSpace / 2,
            trailing: Constants.edgeSpace
        )

        if hasHeader {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(55.0)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    private func generateTheaterLayout(env: NSCollectionLayoutEnvironment, hasHeader: Bool) -> NSCollectionLayoutSection {
        let width = env.container.contentSize.width * 0.7
        let height = width * 0.4
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(width),
            heightDimension: .absolute(height)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(width),
            heightDimension: .absolute(height)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayout])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.itemSpace
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.edgeSpace / 2,
            leading: Constants.edgeSpace,
            bottom: Constants.edgeSpace / 2,
            trailing: Constants.edgeSpace
        )

        if hasHeader {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(55.0)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }

        return section
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, SectionItem> {
        makeCellRegistration()

        let dataSource: UICollectionViewDiffableDataSource<Section, SectionItem> = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, item in
                guard let self else {
                    return UICollectionViewCell()
                }
                switch item {
                case .theater(model: let model), .thumbnail(model: let model), .thumbplay(model: let model):
                    return self.makeCell(on: collectionView, for: indexPath, with: model)
                }
            }
        )

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch dataSource.sectionIdentifier(for: indexPath.section) {
            case .theater(model: let model), .thumbnail(model: let model), .thumbplay(model: let model), .verticalThumbnail(model: let model):
                switch model.headerType {
                case .header:
                    let header: CollectionSampleHeader = collectionView.dequeueSupplementaryView(indexPath: indexPath)
                    header.config(with: model)
                    return header
                case .none:
                    return nil
                }
            case .none:
                return nil
            }
        }

        return dataSource
    }

    private func makeCell(
        on collection: UICollectionView,
        for indexPath: IndexPath,
        with model: CollectionSampleCellViewModel
    ) -> UICollectionViewCell {
        let cell: CollectionSampleCell = collectionView.dequeueReusableCellType(indexPath)
        cell.config(with: model)
        return cell
    }

    enum Section: Hashable {
        case thumbnail(model: CollectionSampleHeaderViewModel)
        case verticalThumbnail(model: CollectionSampleHeaderViewModel)
        case thumbplay(model: CollectionSampleHeaderViewModel)
        case theater(model: CollectionSampleHeaderViewModel)
    }

    enum SectionItem: Hashable {
        case thumbnail(model: CollectionSampleCellViewModel)
        case thumbplay(model: CollectionSampleCellViewModel)
        case theater(model: CollectionSampleCellViewModel)
    }
}
