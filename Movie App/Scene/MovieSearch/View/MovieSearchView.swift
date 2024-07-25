//
//  MovieSearchView.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

final class MovieSearchView: StoryboardedViewController<MovieSearchViewModel, MovieSearchRouter> {

    private enum Constants {
        static let margin = 24.0
        static let itemMargin = 10.0
        static let cellHeight = 90.0
        static let languageIcon = "abc"
    }

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, MovieSearchCellViewModel>?

    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        setupBindings()
        viewModel.action(.viewDidLoad)
    }

    private func configView() { 
        view.backgroundColor = .colorBackground
        setupNavigation()
        setupCollectionView()
        setupMessageLabel()
        searchView.textPublisher.sink { [weak self] text in
            self?.viewModel.action(.search(text))
        }.store(in: &cancellables)
    }

    private func setupMessageLabel() {
        messageLabel.isHidden = true
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = .colorText
        messageLabel.font = Fonts.Body1.medium
    }

    private func setupNavigation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .colorSecondaryBackground
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.colorText,
            .font: Fonts.Title1.bold
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Localized.movieSearch

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: ""),
            primaryAction: UIAction { [weak self] _ in
                self?.viewModel.action(.themeButtonTapped)
            }
        )
        navigationItem.rightBarButtonItem?.tintColor = .colorText

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.languageIcon),
            primaryAction: UIAction { [weak self] _ in
                self?.viewModel.action(.languageButtonTapped)
            }
        )
        navigationItem.leftBarButtonItem?.tintColor = .colorText
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .colorBackground
        collectionView.collectionViewLayout = generateLayout()
        dataSource = makeDataSource()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }

    private func showMessage(_ message: String) {
        collectionView.isHidden = true
        messageLabel.text = message
        messageLabel.isHidden = false
    }

    private func setupBindings() {
        viewModel
            .state
            .compactMap(\.loadingState)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadingState in
                switch loadingState {
                case .notRequested:
                    self?.showMessage(Localized.searchMovie)
                case .isLoading:
                    break
                case .failed:
                    self?.showMessage(Localized.errorHappened)
                case let .success(items):
                    self?.update(with: items)
                }
            }.store(in: &cancellables)

        viewModel
            .state
            .compactMap(\.route)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                switch route {
                case let .movieDetail(movie):
                    self?.router.navigateToDetail(with: movie)
                case .appSettings:
                    self?.router.navigateToAppSettings()
                }
            }.store(in: &cancellables)

        viewModel
            .state
            .compactMap(\.theme)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] theme in
                self?.navigationController?.overrideUserInterfaceStyle = theme.style
                self?.navigationItem.rightBarButtonItem?.image = UIImage(systemName: theme.icon)
            }.store(in: &cancellables)
    }
}

extension MovieSearchView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.action(.itemTapped(indexPath.row))
    }
}

extension MovieSearchView {

    private func makeCellRegistration() {
        collectionView.registerCellTypeForNib(MovieSearchCell.self)
    }

    func update(with items: [MovieSearchCellViewModel]) {
        guard !items.isEmpty else {
            return showMessage(Localized.noSearchResult)
        }
        messageLabel.isHidden = true
        collectionView.isHidden = false
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieSearchCellViewModel>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot)
    }

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case Section.main.rawValue:
                return self?.generateLayout(env: env)
            default:
                return nil
            }
        }
        return layout
    }

    private func generateLayout(env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.itemMargin,
            leading: Constants.margin,
            bottom: 0,
            trailing: Constants.margin
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Constants.cellHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemLayout])

        let section = NSCollectionLayoutSection(group: group)

        return section
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, MovieSearchCellViewModel> {
        makeCellRegistration()

        let dataSource: UICollectionViewDiffableDataSource<Section, MovieSearchCellViewModel> = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, item in
                guard let self else {
                    return UICollectionViewCell()
                }

                return self.makeCell(on: collectionView, for: indexPath, with: item)
            }
        )

        return dataSource
    }

    private func makeCell(
        on collection: UICollectionView,
        for indexPath: IndexPath,
        with model: MovieSearchCellViewModel
    ) -> UICollectionViewCell {
        let cell: MovieSearchCell = collectionView.dequeueReusableCellType(indexPath)
        cell.config(with: model)
        return cell
    }

    enum Section: Int, Hashable, CaseIterable {
        case main
    }
}
