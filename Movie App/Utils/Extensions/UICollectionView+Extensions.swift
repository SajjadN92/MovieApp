//
//  UICollectionView+Extensions.swift
//  Movie App
//
//  Created by Sajjad on 7/25/24.
//

import UIKit

extension UICollectionView {
    func registerCellTypeForNib<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: String(describing: cellType))
    }

    func dequeueReusableCellType<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
}
