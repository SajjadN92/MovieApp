//
//  UICollectionView+Extensions.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

extension UICollectionView {
    func registerCellType<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }

    func registerSupplementaryViewType<View: UICollectionReusableView>(_ viewType: View.Type, kind: String = UICollectionView.elementKindSectionHeader) {
        register(
            viewType,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: String(describing: viewType)
        )
    }

    func registerCellTypeForNib<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: String(describing: cellType))
    }

    func dequeueSupplementaryView<View: UICollectionReusableView>(kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> View {
        return dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: View.self),
            for: indexPath
        ) as! View
    }

    func dequeueReusableCellType<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
}
